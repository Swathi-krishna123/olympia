import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isAdmin = false;
  // Check if the user is an admin by getting the role from SharedPreferences
  Future<void> _checkAdminStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString('role');
    setState(() {
      isAdmin =
          (role == 'admin'); // If the role is 'admin', set isAdmin to true
    });
  }

  String? token;
  @override
  void initState() {
    getData();
    _checkAdminStatus();
    // TODO: implement initState
    var d = Duration(seconds: 2);
    Future.delayed(d, () {
      checkIfuserLoggedinOrnot();
    });
    super.initState();
  }

  Future getData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString('token');
    } catch (e) {
      throw e;
    }
  }

  checkIfuserLoggedinOrnot() async {
    if (token != null) {
      if (isAdmin == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/bottomnavbaradmin',
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/bottomnavbar',
          (route) => false,
        );
      }
      //navigate to home page
    } else {
      //navigate to login page
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/signIn',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: Center(
        child: Text('OLYMPIA', style: Appfonts.mainheading),
      ),
    );
  }
}
