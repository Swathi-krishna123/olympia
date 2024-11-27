import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/customwidgets/buttonwidget.dart';
import 'package:olympia/customwidgets/textform.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({super.key});
   final _formkey=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 100,),
              Text(
                'Forgot Password',
                style: Appfonts.headline,
              ),
              SizedBox(height: 50,),
              TextformfieldCustom(
                controller: emailcontroller,
                hinttext: 'Enter your Email'),
              SizedBox(height: 30,),
              Column(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(onTap: () {
                    
                  },child: ButtonwidgetCustom(button_name: 'Submit', width: 0.8)),
                  SizedBox(height: 10,),
                  TextButton(onPressed: () => Navigator.pop(context),
                  child: Text('Back',style: Appfonts.subheading,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
