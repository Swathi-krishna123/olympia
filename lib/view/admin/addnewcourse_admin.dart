import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/controller/coursesprovider.dart';
import 'package:olympia/model/coursemodel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddnewcourseAdmin extends StatefulWidget {
  final CourseModel? course;
  const AddnewcourseAdmin({super.key, this.course});

  @override
  State<AddnewcourseAdmin> createState() => _AddnewcourseAdminState();
}

class _AddnewcourseAdminState extends State<AddnewcourseAdmin> {
  final formkey = GlobalKey<FormState>();
  bool isLoading = false; // Loading state

  TextEditingController courseNameController = TextEditingController();
  TextEditingController trainerNameController = TextEditingController();
  TextEditingController moreDetailsController = TextEditingController();
  TextEditingController courseFeesController = TextEditingController();
  TextEditingController membershipController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController morningtimecontroller = TextEditingController();
  TextEditingController eveningtimecontroller = TextEditingController();

  bool includeKidsBatch = true;
  bool includeLadiesBatch = true;
  bool includeMorningBatch = true;
  bool includeEveningBatch = true;

  @override
  void dispose() {
    courseNameController.dispose();
    trainerNameController.dispose();
    moreDetailsController.dispose();
    courseFeesController.dispose();
    membershipController.dispose();
    contactNumberController.dispose();
    morningtimecontroller.dispose();
    eveningtimecontroller.dispose();
    Coursesprovider().reset();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.course != null) {
      courseNameController.text = widget.course?.courseName ?? '';
      moreDetailsController.text = widget.course?.moreDetails ?? '';
      trainerNameController.text = widget.course?.trainerName ?? '';
      courseFeesController.text = widget.course?.courseFees ?? '';
      includeEveningBatch = widget.course?.eveningBatch ?? true;
      includeMorningBatch = widget.course?.morningBatch ?? true;
      includeKidsBatch = widget.course?.kidsBatch ?? true;
      includeLadiesBatch = widget.course?.ladiesBatch ?? true;
      membershipController.text = widget.course?.membership ?? '';
      contactNumberController.text = widget.course?.contactNumber ?? '';
      morningtimecontroller.text = widget.course?.morningTime ?? '';
      eveningtimecontroller.text = widget.course?.eveningTime ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<Coursesprovider>(context);

    return AlertDialog(
      title: Text(
        widget.course == null ? 'Add New Course' : 'Edit Course',
        style: Appfonts.normalheading,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textform(
                  controller: courseNameController, labelText: 'Course Name'),
              GestureDetector(
                onTap: () async {
                  await courseProvider.pickImage();
                  if (courseProvider.selectedImage != null) {
                    await courseProvider.uploadImage();
                  }
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: courseProvider.selectedImage != null
                      ? Image.file(
                          courseProvider.selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : (widget.course?.courseImage != null &&
                              widget.course!.courseImage!.isNotEmpty
                          ? Image.network(
                              widget.course!.courseImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image,
                                    color: Colors.red);
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Icon(Icons.add_a_photo, color: Colors.grey[700])),
                ),
              ),
              const SizedBox(height: 10),
              Textform(
                  controller: moreDetailsController, labelText: 'More Details'),
              const SizedBox(height: 10),
              Text('Include:', style: Appfonts.normaltext),
              CheckboxListTile(
                activeColor: Appcolors.themecolor,
                title: Text('Morning Batch', style: Appfonts.hinttext),
                value: includeMorningBatch,
                onChanged: (bool? value) {
                  setState(() {
                    includeMorningBatch = value!;
                  });
                },
              ),
              CheckboxListTile(
                activeColor: Appcolors.themecolor,
                title: Text('Evening Batch', style: Appfonts.hinttext),
                value: includeEveningBatch,
                onChanged: (bool? value) {
                  setState(() {
                    includeEveningBatch = value!;
                  });
                },
              ),
              CheckboxListTile(
                activeColor: Appcolors.themecolor,
                title: Text('Kids Batch', style: Appfonts.hinttext),
                value: includeKidsBatch,
                onChanged: (bool? value) {
                  setState(() {
                    includeKidsBatch = value!;
                  });
                },
              ),
              CheckboxListTile(
                activeColor: Appcolors.themecolor,
                title: Text('Ladies Batch', style: Appfonts.hinttext),
                value: includeLadiesBatch,
                onChanged: (bool? value) {
                  setState(() {
                    includeLadiesBatch = value!;
                  });
                },
              ),
              Textform(
                  controller: morningtimecontroller, labelText: 'Morning Time'),
              Textform(
                  controller: eveningtimecontroller, labelText: 'Evening Time'),
              Textform(
                  controller: trainerNameController, labelText: 'Trainer Name'),
              Textform(
                  controller: contactNumberController,
                  labelText: 'Contact Number'),
              Textform(
                  controller: courseFeesController, labelText: 'Course Fees'),
              Textform(
                  controller: membershipController, labelText: 'Membership'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      actions: isLoading
          ? [const Center(child: CircularProgressIndicator())]
          : [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: Appfonts.normaltext)),
              ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                       setState(() {
                      isLoading = true; // Start loading
                    });
                      try {
                        var courseid =
                            widget.course?.courseId ?? const Uuid().v4();
                        // Get the uploaded image URL, or fall back to the current image
                        String? imageUrl = courseProvider.uploadedImageUrl ??
                            widget.course?.courseImage;
                        CourseModel courseModel = CourseModel(
                          courseId: courseid,
                          courseName: courseNameController.text,
                          contactNumber: contactNumberController.text,
                          courseFees: courseFeesController.text,
                          courseImage: imageUrl,
                          eveningBatch: includeEveningBatch,
                          eveningTime: eveningtimecontroller.text,
                          kidsBatch: includeKidsBatch,
                          ladiesBatch: includeLadiesBatch,
                          morningBatch: includeMorningBatch,
                          membership: membershipController.text,
                          moreDetails: moreDetailsController.text,
                          morningTime: morningtimecontroller.text,
                          trainerName: trainerNameController.text,
                        );

                        if (widget.course == null) {
                          await courseProvider.addCourse(courseModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Successfully added Course')));
                          Navigator.pop(context);
                        } else {
                          await courseProvider.editCourse(courseModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Successfully updated Course')));
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e.toString());
                      }finally {
                      setState(() {
                        isLoading = false; // Stop loading after operation completes
                      });
                    }
                    }
                  },
                  child: Text(widget.course == null ? 'Add' : 'Save',
                      style: Appfonts.normaltext))
            ],
    );
  }
}

// ignore: must_be_immutable
class Textform extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  Textform({
    super.key,
    required this.controller,
    required this.labelText,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required field";
        }
        return null;
      },
      decoration:
          InputDecoration(labelText: labelText, labelStyle: Appfonts.hinttext),
    );
  }
}
