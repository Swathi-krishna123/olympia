import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/customwidgets/buttonwidget.dart';
import 'package:olympia/customwidgets/textform.dart';
class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});
 

  @override
  Widget build(BuildContext context) {
    final phonecontroller=TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              'O T P Verification',
              style: Appfonts.headline,
            ),
            const SizedBox(
              height: 50,
            ),
            TextformfieldCustom(
              controller: phonecontroller,
              hinttext: 'Enter your Phone Number'),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/otpconfirm');
    
                    },
                    child:
                        ButtonwidgetCustom(button_name: 'Submit', width: 0.755)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/signIn',
                          (route) => false,
                        ),
                    child: Text(
                      'Back',
                      style: Appfonts.subheading,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}



//   class Dialoguebox{

// Future<void> dialogBuilder(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
          
//           title:  Text('Enter The O T P',style: Appfonts.normalheading,),
//           content:  
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Disable'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Enable'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }


//   }

