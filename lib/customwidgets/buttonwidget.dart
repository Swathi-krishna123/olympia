import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';

// ignore: must_be_immutable
class ButtonwidgetCustom extends StatelessWidget {
  String button_name;
  double width;
  ButtonwidgetCustom(
      {super.key, required this.button_name, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolors.primarycolor,
      width: MediaQuery.of(context).size.width * width,
      height: 50,
      child: Center(child: Text(button_name, style: Appfonts.blackbutton)),
    );
  }
}
