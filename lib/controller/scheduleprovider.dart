// import 'package:flutter/material.dart';
// import 'package:olympia/model/coursemodel.dart';

// class ScheduleProvider with ChangeNotifier {
//   String selectedCourse = 'Select Course';

//   final Map<String, Map<String, String>> courseSchedules = {
//     'Kung Fu': {'morning': '7:30 AM - 9:30 AM', 'evening': '5:30 PM - 7:30 PM'},
//     'Karate': {'morning': '8:00 AM - 10:00 AM', 'evening': '6:00 PM - 8:00 PM'},
//     'MMA': {'morning': '6:30 AM - 8:30 AM', 'evening': '4:30 PM - 6:30 PM'},
//   };



//   Map<String, String> get selectedCourseSchedule => courseSchedules[selectedCourse] ?? {};

//   void changeCourse(String course) {
//     selectedCourse = course;
//     notifyListeners();
//   }

//   void updateSchedule(String course, String morningTime, String eveningTime) {
//     courseSchedules[course] = {'morning': morningTime, 'evening': eveningTime};
//     notifyListeners();
//   }
// }
