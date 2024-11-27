import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';

class NotificationAdminPage extends StatelessWidget {
  const NotificationAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: Appfonts.normalheading,
        ),
        iconTheme: const IconThemeData.fallback(),
      ),
    );
  }
}
