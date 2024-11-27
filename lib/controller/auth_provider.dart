import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olympia/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection('USERS');
  final CollectionReference _adminCollection =
      FirebaseFirestore.instance.collection('ADMINS');

  // Register User Function
 Future<Object?> registerUser(UserModel usermodel) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: usermodel.email.toString(),
      password: usermodel.password.toString(),
    );

    final userEmail = userCredential.user!.email.toString();

    if (userEmail.endsWith('@admin.com')) {
      await _adminCollection.doc(userCredential.user!.uid).set({
        "name": usermodel.name,
        "id": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "password": usermodel.password,
        "phone": usermodel.phone,
        "role": 'admin',
      });
    } else {
      await _usercollection.doc(userCredential.user!.uid).set({
        "name": usermodel.name,
        "id": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "password": usermodel.password,
        "phone": usermodel.phone,
      });
    }

    notifyListeners();
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 'already_exists'; // Return a value to indicate the user already exists
    } else {
      print('Error: ${e.message}');
    }
  }
  return null;
}

// Login user method
 Future<DocumentSnapshot> loginUser(UserModel usermodel) async {
  DocumentSnapshot docs;
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    // Attempt to sign in with email and password
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: usermodel.email.toString(),
      password: usermodel.password.toString(),
    );

    // Check if the user is an admin
    docs = await _adminCollection.doc(userCredential.user!.uid).get();
    if (docs.exists) {
      // If the user is an admin, handle accordingly
      await _storeUserDataInPrefs(docs, pref, 'admin');
    } else {
      // If not found in admin collection, check in user collection
      docs = await _usercollection.doc(userCredential.user!.uid).get();
      if (docs.exists) {
        await _storeUserDataInPrefs(docs, pref, 'user');
      } else {
        throw FirebaseAuthException(
            message: "User not found", code: "user-not-found");
      }
    }

    return docs;
  } on FirebaseAuthException catch (e) {
    throw e;
  }
}

// Helper method to store user data in SharedPreferences
Future<void> _storeUserDataInPrefs(
    DocumentSnapshot docs, SharedPreferences pref, String role) async {
  String? token = await _auth.currentUser!.getIdToken();
  await pref.setString('token', token!);
  await pref.setString('userId', docs['id']);
  await pref.setString('email', docs['email']);
  await pref.setString('role', role);  // Store user role (admin or user)
}


  // Sign Out Function
  Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear the stored login state
    notifyListeners();
  }
}
