import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';

// ignore: must_be_immutable
class TextformfieldCustom extends StatefulWidget {
  String? hinttext;
  IconData? prefixicon;
  bool suffixIcon;
  bool isobsecure;
  TextEditingController? controller;
    // Validation variable to hold the validation function
  String? Function(String?)? validateInput;
  
  TextformfieldCustom({
    super.key,
    this.controller,
    this.hinttext,
    this.prefixicon,
    this.suffixIcon = false,
    this.isobsecure = false,
    this.validateInput
  });

  @override
  State<TextformfieldCustom> createState() => _TextformfieldCustomState();
}

class _TextformfieldCustomState extends State<TextformfieldCustom> {




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isobsecure,
        validator: widget.validateInput,  // Use the validation function here
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(widget.prefixicon),
          ),
          prefixIconColor: Appcolors.hintcolor,
          hintText: widget.hinttext,
          hintStyle: Appfonts.hinttext,
          floatingLabelStyle: Appfonts.normaltext,
          filled: true,
          fillColor: Appcolors.themecolor,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.isobsecure = !widget.isobsecure;
                });
              },
              child: widget.suffixIcon
                  ? Icon(widget.isobsecure ? Appicons.closedeye : Appicons.openeye)
                  : const Icon(null),
            ),
          ),
        ),
      ),
    );
  }
}
