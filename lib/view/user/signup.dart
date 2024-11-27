import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';
import 'package:olympia/controller/auth_provider.dart';
import 'package:olympia/customwidgets/buttonwidget.dart';
import 'package:olympia/customwidgets/textform.dart';
import 'package:olympia/model/usermodel.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final usernamecontroller = TextEditingController();
    final emailcontroller = TextEditingController();
    final passwordcontroller = TextEditingController();
    final confirmcontroller = TextEditingController();
    final phonecontroller = TextEditingController();

    // Validation for phone number
    String? validatePhoneNumber(String? value) {
      if (value == null || value.isEmpty) {
        return 'Phone number is required';
      }
      final phoneRegex = RegExp(r'^\d{10}$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Enter a valid 10-digit phone number';
      }
      return null;
    }

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 50),
                  Center(child: Text('SIGN UP', style: Appfonts.headline)),
                  const SizedBox(height: 50),

                  // Username Field
                  TextformfieldCustom(
                    validateInput: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    controller: usernamecontroller,
                    hinttext: 'Username',
                    prefixicon: Appicons.user,
                  ),
                  const SizedBox(height: 10),

                  // Email Field
                  TextformfieldCustom(
                    validateInput: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // Regular expression for email validation
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: emailcontroller,
                    hinttext: 'Email',
                    prefixicon: Appicons.email,
                  ),
                  const SizedBox(height: 10),

                  // Phone Number Field with validation
                  TextformfieldCustom(
                    validateInput:
                        validatePhoneNumber, // Apply phone number validation here
                    controller: phonecontroller,
                    hinttext: 'Phone Number',
                    prefixicon: Appicons.phone,
                  ),
                  const SizedBox(height: 10),

                  // Password Field
                  TextformfieldCustom(
                    validateInput: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    controller: passwordcontroller,
                    hinttext: 'Password',
                    prefixicon: Appicons.password,
                    suffixIcon: true,
                    isobsecure: true,
                  ),
                  const SizedBox(height: 10),

                  // Confirm Password Field
                  TextformfieldCustom(
                    validateInput: (value) {
                      if (value != passwordcontroller.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: confirmcontroller,
                    hinttext: 'Confirm Password',
                    prefixicon: Appicons.password,
                    isobsecure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signIn');
                      },
                      child: Text('Sign In here', style: Appfonts.subheading),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            UserModel userModel = UserModel(
                              name: usernamecontroller.text,
                              email: emailcontroller.text,
                              id: '',
                              password: passwordcontroller.text,
                              phone: phonecontroller.text,
                            );

                            final userdata =
                                await value.registerUser(userModel);

                            if (userdata != null &&
                                userdata == 'already_exists') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('User already exists')));
                            } else if (userdata != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Registration success')));

                              Navigator.pushReplacementNamed(
                                  context, '/signIn');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Registration failed')));
                            }
                          }
                        },
                        child: Center(
                            child: ButtonwidgetCustom(
                                button_name: 'Sign Up', width: 0.755)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
