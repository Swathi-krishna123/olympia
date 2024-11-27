import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/customwidgets/buttonwidget.dart';

class Otpconfirm extends StatelessWidget {
  const Otpconfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            Text('Enter The OTP',style: Appfonts.headline,),
            const SizedBox(height: 30,),
            OtpTextField(
              filled: true,
              fillColor: Appcolors.themecolor,
              fieldWidth: 50,
              fieldHeight: 50,
              numberOfFields: 5,
              borderColor:Appcolors.primarycolor,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              // onSubmit: (String verificationCode) {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text("Verification Code"),
                //         content: Text('Code entered is $verificationCode'),
                //       );
                //     });
               
              // }, // end onSubmit
            ),
            const SizedBox(height: 30,),
             GestureDetector(onTap: () {
               Navigator.pushNamedAndRemoveUntil(context, '/bottomnavbar', (route) => false,);
             },child: Expanded(child: ButtonwidgetCustom(button_name: 'Submit', width: 0.79))),
          ],
        ),
      ),
    );
  }
}
