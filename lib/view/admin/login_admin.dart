// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:olympia/constants/colors.dart';
// import 'package:olympia/constants/fonts.dart';
// import 'package:olympia/customwidgets/buttonwidget.dart';
// import 'package:olympia/customwidgets/textform.dart';

// class LoginAdmin extends StatelessWidget {
//    LoginAdmin({super.key});
//   final usernamecontroller=TextEditingController();
//   final passwordcontroller=TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               Text('SIGN IN', style: Appfonts.headline),
//               const SizedBox(
//                 height: 50,
//               ),
//               TextformfieldCustom(
//                 controller:usernamecontroller ,
//                 hinttext: 'username',
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextformfieldCustom(
//                     controller: passwordcontroller,
//                     hinttext: 'password'),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 30,
//                     ),
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/forgotpassword');
//                         },
//                         child: Text(
//                           'Forgot Password?',
//                           style: Appfonts.subheading,
//                         )),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               InkWell(
//                 onTap: () => Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   '/bottomnavbaradmin',
//                   (route) => false,
//                 ),
//                 child: ButtonwidgetCustom(
//                   button_name: 'Sign In',
//                   width: 0.755,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'or',
//                 style: GoogleFonts.aldrich(
//                     fontSize: 15, color: Appcolors.primarycolor),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Sign In with Google',
//                     style: Appfonts.subheading,
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
