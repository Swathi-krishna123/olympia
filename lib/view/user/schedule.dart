// import 'package:flutter/material.dart';
// import 'package:olympia/constants/colors.dart';
// import 'package:olympia/constants/fonts.dart';
// import 'package:olympia/controller/coursesprovider.dart';
// import 'package:olympia/model/coursemodel.dart';
// import 'package:provider/provider.dart';

// class Schedule extends StatefulWidget {
//   const Schedule({super.key});

//   @override
//   State<Schedule> createState() => _ScheduleState();
// }

// class _ScheduleState extends State<Schedule> {
//   String? selectedCourse;
//   String morningTime = 'Not Available';
//   String eveningTime = 'Not Available';



  

//   @override
  
//   Widget build(BuildContext context) {
//     final coursesProvider = Provider.of<Coursesprovider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Schedule',
//           style: Appfonts.headline,
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 selectedCourse ?? 'Courses',
//                 style: Appfonts.normaltext,
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.arrow_drop_down_outlined,
//                   color: Appcolors.primarycolor,
//                 ),
//                 onPressed: () {
//                   // Show popup when clicking the icon
//                   showMenu(
//                     context: context,
//                     position: RelativeRect.fromLTRB(100, 80, 0, 0),
//                     items: coursesProvider.courses
//                         .map<PopupMenuItem<String>>(
//                           (course) => PopupMenuItem<String>(
//                             value: course['name'],
//                             child: ListTile(
//                               title: Text(course['name']),
//                               onTap: () {
//                                 // Set the selected course and times
//                                 setState(() {
//                                   selectedCourse = course['name'];
//                                   morningTime = course['morningtime'] ?? 'Not Available';
//                                   eveningTime = course['eveningtime'] ?? 'Not Available';
//                                 });
//                                 Navigator.pop(context); // Close the menu after selection
//                               },
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 40,
//                 color: Appcolors.themecolor,
//                 child: Center(
//                   child: Text(
//                     selectedCourse ?? 'Course Name',
//                     style: Appfonts.normalheading,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 width: MediaQuery.of(context).size.width,
//                 height: 200,
//                 color: Colors.white,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
                    
//                       Text(
//                         'Morning Time : $morningTime AM',
//                         style: Appfonts.normalheading,
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         'Evening Time : $eveningTime PM',
//                         style: Appfonts.normalheading,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/controller/coursesprovider.dart';
import 'package:olympia/model/coursemodel.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String? selectedCourse;
  String morningTime = 'Not Available';
  String eveningTime = 'Not Available';

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<Coursesprovider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Schedule',
          style: Appfonts.headline,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StreamBuilder<List<CourseModel>>(
              stream: coursesProvider.fetchCourses(),
              builder: (context, snapshot) {
                // Check for loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator
                }

                // Check for errors
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // If the snapshot has no data
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No courses available');
                }

                // List of courses
                List<CourseModel> courses = snapshot.data!;

                return DropdownButton<String>(
                  value: selectedCourse,
                  hint: Text('Select Course'),
                  icon: Icon(Icons.arrow_drop_down_outlined, color: Appcolors.primarycolor),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCourse = newValue;

                      // Set times based on selected course
                      if (newValue != null) {
                        final selectedCourseModel = courses.firstWhere(
                          (course) => course.courseName == newValue, // Assuming 'name' is a property of CourseModel
                        );
                        morningTime = selectedCourseModel.morningTime ?? 'Not Available';
                        eveningTime = selectedCourseModel.eveningTime ?? 'Not Available';
                      }
                    });
                  },
                  items: courses.map((course) {
                    return DropdownMenuItem<String>(
                      value: course.courseName, // Assuming 'name' is a property of CourseModel
                      child: Text(course.courseName.toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: Appcolors.themecolor,
                child: Center(
                  child: Text(
                    selectedCourse ?? 'Course Name',
                    style: Appfonts.normalheading,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Morning Time : $morningTime AM',
                        style: Appfonts.normalheading,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Evening Time : $eveningTime PM',
                        style: Appfonts.normalheading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
