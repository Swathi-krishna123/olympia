import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';
import 'package:olympia/controller/attendanceprovider.dart';
import 'package:olympia/model/usermodel.dart';
import 'package:provider/provider.dart';

class AttendanceAdmin extends StatelessWidget {
  AttendanceAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    return Scaffold(
      backgroundColor: Appcolors.secondarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Appcolors.themecolor,
        surfaceTintColor: Appcolors.themecolor,
        title: Text(
          'Attendance',
          style: Appfonts.headline,
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (course) {
              attendanceProvider.filterStudentsByCourse(course);
            },
            icon: Row(
              children: [
                Text(
                  attendanceProvider.selectedCourse.isEmpty
                      ? 'Select Course'
                      : attendanceProvider.selectedCourse,
                  style: Appfonts.normaltext,
                ),
                Icon(Icons.arrow_drop_down_outlined),
              ],
            ),
            itemBuilder: (BuildContext context) {
              final courses = attendanceProvider.courses;
              if (courses.isEmpty) {
                return [
                  PopupMenuItem<String>(
                    value: '',
                    child: Text('No Courses Available', style: Appfonts.normaltext),
                  ),
                ];
              } else {
                return courses.map((String course) {
                  return PopupMenuItem<String>(
                    value: course,
                    child: Text(course, style: Appfonts.normaltext),
                  );
                }).toList();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: attendanceProvider.selectedCourse.isEmpty
            ? Center(child: Text('Select Course to view students', style: Appfonts.hinttext))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search students',
                        hintStyle: Appfonts.hinttext,
                        prefixIcon: Icon(Appicons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        attendanceProvider.searchStudents(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: attendanceProvider.filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = attendanceProvider.filteredStudents[index];
                        return AttendanceTile(
                          student: student,
                          index: index + 1,
                          onAttendanceChanged: (isPresent) => attendanceProvider
                              .toggleAttendance(index, isPresent),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Appcolors.themecolor),
                          ),
                          onPressed: () {
                            attendanceProvider.markAllPresent();
                          },
                          child: Text(
                            'Mark All Present',
                            style: Appfonts.normaltext,
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Appcolors.primarycolor),
                          ),
                          onPressed: () {
                            // Implement submit functionality
                            // For example:
                            // attendanceProvider.submitAttendance();
                          },
                          child: Text(
                            'Submit',
                            style: Appfonts.normaltextwhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class AttendanceTile extends StatelessWidget {
  final UserModel student;
  final int index;
  final ValueChanged<bool?> onAttendanceChanged;

  const AttendanceTile({
    Key? key,
    required this.student,
    required this.index,
    required this.onAttendanceChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        index.toString(),
        style: TextStyle(color: Appcolors.primarycolor),
      ),
      title: Text(
        student.name ?? 'Unknown',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        student.id ?? 'No ID',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Checkbox(
        value: student.isPresent,
        onChanged: onAttendanceChanged,
        activeColor: Appcolors.themecolor,
        checkColor: Appcolors.secondarycolor,
      ),
    );
  }
}
