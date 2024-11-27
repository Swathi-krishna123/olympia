import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile',style: Appfonts.headline,),),
      body: const Center(child: Text('profile'),),);
  }
}