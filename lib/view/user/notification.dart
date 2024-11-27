import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification',style: Appfonts.normalheading,) ,iconTheme: IconThemeData.fallback(),),
    );
  }
}