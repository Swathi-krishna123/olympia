import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olympia/model/coursemodel.dart';

class Coursesprovider with ChangeNotifier {
  List<Map<String, dynamic>> courses = [];
  final CollectionReference _courseCollection =
      FirebaseFirestore.instance.collection('COURSES');

  //IMAGE

  final firbasestorage = FirebaseStorage.instance;
  File? _selectedImage;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  File? get selectedImage => _selectedImage;
  String? get uploadedImageUrl => _uploadedImageUrl;
  bool get isUploading => _isUploading;

  final ImagePicker _picker = ImagePicker();

  String? get selectedImageUrl => null;

  Future<CourseModel?> addCourse(CourseModel coursemodel) async {
    try {
      final coursemap = coursemodel.tomap();
      await _courseCollection.doc(coursemodel.courseId).set(coursemap);
      notifyListeners();
      return coursemodel;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //update
  Future<CourseModel?> updatecourse(CourseModel course) async {
    try {
      final coursemap = course.tomap();
      await _courseCollection.doc(course.courseId).update(coursemap);
      notifyListeners();
      return course;
    } on FirebaseException catch (e) {
      print(e.toString());
    }return null;
  }

  Stream<List<CourseModel>> fetchCourses() {
    return _courseCollection.snapshots().map((snapshot) {
      // Map Firebase documents to CourseModel
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CourseModel.fromjson(data);
      }).toList();
      
    });
  }

  Future<void> editCourse(CourseModel course) async {

    try {
      final coursemap = course.tomap();
      await _courseCollection.doc(course.courseId).update(coursemap);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteCourse(CourseModel course) async {
    try {
      // Assuming you have a reference to your Firestore collection
      await _courseCollection
          .doc(course.courseId)
          .delete(); // Delete from Firestore
      courses.remove(course); // Remove from local list
      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      print('Error deleting course: $e');
    }
  }

  // Function to pick image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Function to upload image to Firebase Storage
  Future<void> uploadImage() async {
    if (_selectedImage == null) return;

    _isUploading = true;
    notifyListeners();

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('course_images/$fileName');

      UploadTask uploadTask = storageRef.putFile(_selectedImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      _uploadedImageUrl = await taskSnapshot.ref.getDownloadURL();

      _isUploading = false;
      notifyListeners();

      // Display success message
      print('Image uploaded successfully: $_uploadedImageUrl');
    } catch (e) {
      _isUploading = false;
      print('Failed to upload image: $e');
      notifyListeners();
    }
  }

  // Function to reset image selection and upload status
  void reset() {
    _selectedImage = null;
    _uploadedImageUrl = null;
    _isUploading = false;
    notifyListeners();
  }
}
