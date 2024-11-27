import 'package:flutter/material.dart';
import 'package:olympia/model/usermodel.dart';

class AttendanceProvider with ChangeNotifier {
  // Maintain a list of students for all courses
  final List<UserModel> students = [
    UserModel(name: 'John Doe', id: 'S001', course: 'Karate'),
    UserModel(name: 'Jane Smith', id: 'S002', course: 'Kungfu'),
    UserModel(name: 'Arjun', id: 'S003', course: 'Taekwondo'),
    UserModel(name: 'Ravi Kumar', id: 'S004', course: 'Judo'),
    // Add more students for different courses...
  ];

  List<UserModel> filteredStudents = [];
  String selectedCourse = 'Select Course';
  final List<String> courses = ['Karate', 'Kungfu', 'Taekwondo', 'Judo'];

  // Filter students based on the selected course
  void filterStudentsByCourse(String course) {
    filteredStudents =
        students.where((student) => student.course == course).toList();
    selectedCourse = course;
    notifyListeners(); 
  }

  void toggleAttendance(int index, bool? isPresent) {
    filteredStudents[index].isPresent = isPresent ?? false;
    notifyListeners();
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.clear();
    } else {
      filteredStudents = students.where((student) {
        return student.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void markAllPresent() {
    for (var student in filteredStudents) {
      student.isPresent = true;
    }
    notifyListeners();
  }
}
