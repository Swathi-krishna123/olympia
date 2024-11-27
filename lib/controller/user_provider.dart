import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  bool _isAdmin = false;

  bool get isAdmin => _isAdmin;

  Future<void> checkAdminStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString('role');
    _isAdmin = (role == 'admin');
    notifyListeners(); // Notify the listeners to update UI if needed
  }
}
