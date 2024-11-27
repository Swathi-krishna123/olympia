import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';

class StudentDetailsPage extends StatelessWidget {
  final Map<String, String> student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       iconTheme: IconThemeData.fallback(),
        title: Text(
          '${student['name']} Details',
          style: Appfonts.headline,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${student['name']}',
              style: Appfonts.normaltext,
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${student['email']}',
              style: Appfonts.normaltext,
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: ${student['phone']}',
              style: Appfonts.normaltext,
            ),
            const SizedBox(height: 10),
            Text(
              'Course: ${student['course']}',
              style: Appfonts.normaltext,
            ),
          ],
        ),
      ),
    );
  }
}
