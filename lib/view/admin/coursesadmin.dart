import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';
import 'package:olympia/controller/coursesprovider.dart';
import 'package:olympia/controller/user_provider.dart';
import 'package:olympia/customwidgets/textform.dart';
import 'package:olympia/model/coursemodel.dart';
import 'package:olympia/view/admin/addnewcourse_admin.dart';
import 'package:olympia/view/user/course_detaills_page.dart';
import 'package:provider/provider.dart';

class CoursesAdmin extends StatefulWidget {
  const CoursesAdmin({super.key});

  @override
  State<CoursesAdmin> createState() => _CoursesAdminState();
}

class _CoursesAdminState extends State<CoursesAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProvider().checkAdminStatus();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final coursesProvider = Provider.of<Coursesprovider>(context);

    // Show delete confirmation dialog for admin users
    Future<void> showDeleteDialog(CourseModel course) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete Course',
              style: Appfonts.normalheading,
            ),
            content: Text(
              'Are you sure you want to delete this course?',
              style: Appfonts.normaltext,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  coursesProvider.fetchCourses();
                  // Close the dialog
                },
                child: Text(
                  'Cancel',
                  style: Appfonts.subheading1,
                ),
              ),
              TextButton(
                onPressed: () async {
                  coursesProvider.deleteCourse(
                    course,
                  ); // Call delete function from provider
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Delete',
                  style: Appfonts.subheading1,
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: userProvider.isAdmin
          ? FloatingActionButton(
              backgroundColor: Appcolors.themecolor,
              foregroundColor: Appcolors.primarycolor,
              onPressed: () {
                coursesProvider.reset();
                showDialog(
                  context: context,
                  builder: (context) => const AddnewcourseAdmin(),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: StreamBuilder<List<CourseModel>>(
        stream: coursesProvider.fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<CourseModel> courses = snapshot.data!;

            if (courses.isEmpty) {
              return const Center(child: Text('No courses available'));
            }

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                CourseModel course = courses[index];
                return ListTile(
                  trailing: userProvider.isAdmin
                      ? IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddnewcourseAdmin(
                                course: course,
                              ),
                            );
                          },
                          icon: Icon(Appicons.edit))
                      : TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return JoinDetails();
                              },
                            );
                          },
                          child: Text(
                            'Join',
                            style: Appfonts.normaltext,
                          )),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseDetailsPage(
                      course: course,
                    ),
                  )),
                  onLongPress: userProvider.isAdmin
                      ? () {
                          showDeleteDialog(course);
                        }
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Text(
                    (index + 1).toString(),
                    style: Appfonts.yellow,
                  ),
                  title: Text(
                    course.courseName ?? 'No Name',
                    style: Appfonts.normalheading,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class JoinDetails extends StatefulWidget {
  JoinDetails({
    super.key,
  });

  @override
  State<JoinDetails> createState() => _JoinDetailsState();
}

class _JoinDetailsState extends State<JoinDetails> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController phonenumbercontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController courseNameController = TextEditingController();

  String batch = 'Morning';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Details'),
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextformfieldCustom(
                  controller: usernamecontroller,
                  hinttext: 'UserName',
                  validateInput: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                TextformfieldCustom(
                  controller: phonenumbercontroller,
                  hinttext: 'PhoneNumber',
                  validateInput: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                TextformfieldCustom(
                  controller: emailcontroller,
                  hinttext: 'Email',
                  validateInput: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                TextformfieldCustom(
                  controller: courseNameController,
                  hinttext: 'Course Name',
                  validateInput: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('Select Batch:'),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Morning'),
                        value: 'Morning',
                        groupValue: batch,
                        onChanged: (value) {
                          setState(() {
                            batch = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Evening'),
                        value: 'Evening',
                        groupValue: batch,
                        onChanged: (value) {
                          setState(() {
                            batch = value!;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
      actions: [ TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Appcolors.themecolor),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(); // Close the dialog
            }
          },
          child: Text(
            'Join',
            style: Appfonts.normaltextyellow,
          ),
        ),
       
      ],
    );
  }
}
