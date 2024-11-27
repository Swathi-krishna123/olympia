import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/controller/auth_provider.dart';
import 'package:olympia/customwidgets/buttonwidget.dart';
import 'package:olympia/customwidgets/textform.dart';
import 'package:olympia/model/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
   bool _isloading=false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  // Redirect user based on role (admin or user)
  void _redirectUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString('role');

    if (role == 'admin') {
      Navigator.pushReplacementNamed(context, '/bottomnavbaradmin');
    } else {
      Navigator.pushReplacementNamed(context, '/bottomnavbar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text('SIGN IN', style: Appfonts.headline),
                    const SizedBox(height: 50),
                    TextformfieldCustom(
                      controller: emailcontroller,
                      hinttext: 'Email id',
                      validateInput: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Regular expression for email validation
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextformfieldCustom(
                          controller: passwordcontroller,
                          hinttext: 'Password',
                          isobsecure: true,
                          validateInput: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgotpassword');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Appfonts.subheading,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                               setState(() {
                                  _isloading=true;
                               });
                                final authProvider = Provider.of<AuthProvider>(
                                    context,
                                    listen: false);
                                UserModel userModel = UserModel(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                                final userdata =
                                    await authProvider.loginUser(userModel);
            
                                if (userdata != null) {
                                
                                 Future.delayed(Duration(seconds: 2),() =>  _redirectUser(),)  ;// Redirect user based on role
                                  
                                }
                              } catch (e) {
                               setState(() {
                                  _isloading=false;
                               });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Invalid User!')),
                                );
                              }
                            }
                          },
                          child: ButtonwidgetCustom(
                            button_name: 'Sign In',
                            width: 0.755,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signUp');
                          },
                          child: Text(
                            'Sign Up here!',
                            style: Appfonts.subheading,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'or',
                      style: GoogleFonts.aldrich(
                        fontSize: 15,
                        color: Appcolors.primarycolor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Handle Google sign-in
                      },
                      child: Text(
                        'Sign In with Google',
                        style: Appfonts.subheading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isloading)
              Container(
                color: Colors.black.withOpacity(0.5), // Optional dark background
                child: Center(
                  child: Container(height: 60,width: 60,color: Appcolors.secondarycolor,
                    child:  Center(
                      child: CircularProgressIndicator(color: Appcolors.themecolor,), // Show loading spinner
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
