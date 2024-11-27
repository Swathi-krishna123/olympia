import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/view/admin/studentdetails.dart';

class Studentslist extends StatefulWidget {
  const Studentslist({super.key});

  @override
  _StudentslistState createState() => _StudentslistState();
}

class _StudentslistState extends State<Studentslist> {
  // Sample list of students. You can replace this with your actual data.
  List<Map<String, String>> students = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '1234567890',
      'course': 'Martial Arts'
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'phone': '0987654321',
      'course': 'Kickboxing'
    },
    {
      'name': 'Alex Johnson',
      'email': 'alex.johnson@example.com',
      'phone': '1122334455',
      'course': 'Karate'
    },
    {
      'name': 'Emily Brown',
      'email': 'emily.brown@example.com',
      'phone': '5566778899',
      'course': 'Taekwondo'
    },
  ];

  List<Map<String, String>> filteredStudents = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStudents = students; // Initially show all students
    searchController.addListener(() {
      filterStudents();
    });
  }

  void filterStudents() {
    setState(() {
      filteredStudents = students
          .where((student) => student['name']!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Students List',
          style: Appfonts.headline,
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Students',
                labelStyle: Appfonts.hinttext,
                border: OutlineInputBorder(
                  
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredStudents.isEmpty
                ? Center(
                    child: Text(
                      'No students found',
                      style: Appfonts.normaltext,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];

                      return ListTile(
                        leading: Text((index + 1).toString()),
                        title: Text(
                          student['name']!,
                          style: Appfonts.normaltext,
                        ),
                        onTap: () {
                          // Navigate to the student details page and pass the student data
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StudentDetailsPage(
                                student: student,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
