import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/model/coursemodel.dart';
import 'package:olympia/customwidgets/buttonwidget.dart';

class CourseDetailsPage extends StatelessWidget {
  final CourseModel course;

  const CourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          course.courseName ?? "Course Details",
          style: Appfonts.normalheading,
        ),
        iconTheme: const IconThemeData.fallback(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                course.courseImage != null && course.courseImage!.isNotEmpty
                    ? Image.network(
                        "${course.courseImage}?timestamp=${DateTime.now().millisecondsSinceEpoch}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, color: Colors.red);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      )
                    : const Icon(Icons.add_a_photo, color: Colors.grey),
                TextButton(
                  onPressed: () {
                    // Assuming moreDetails is a String
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(title: const Text("More Details")),
                          body: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              course.moreDetails ?? "No details available.",
                              style: Appfonts.subheading,
                            ),
                          ),
                        );
                      },
                    ));
                  },
                  child: Text(
                    'More Details',
                    style: Appfonts.subheading,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Appcolors.secondarycolor),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trainer Name: ${course.trainerName ?? "N/A"}',
                          style: Appfonts.normaltext,
                        ),
                        const SizedBox(height: 10),
                        Text('Batches:', style: Appfonts.normaltext),
                        const SizedBox(height: 10),
                        if (course.morningBatch == true)
                          _batchIndicator('Morning'),
                        if (course.eveningBatch == true)
                          _batchIndicator('Evening'),
                        if (course.ladiesBatch == true)
                          _batchIndicator('Ladies'),
                        if (course.kidsBatch == true) _batchIndicator('Kids'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Course Fees:',
                              style: Appfonts.normaltext,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '/- ${course.courseFees} (monthly)',
                              style: Appfonts.normaltext,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            '/- ${course.membership} (Membership)',
                            style: Appfonts.normaltext,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Contact Number: ${course.contactNumber ?? "N/A"}',
                          style: Appfonts.normaltext,
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _batchIndicator(String batchName) {
    return Row(
      children: [
        const SizedBox(width: 40),
        Icon(Icons.circle, size: 6, color: Appcolors.primarycolor),
        const SizedBox(width: 10),
        Text(batchName, style: Appfonts.normaltext),
      ],
    );
  }
}
