// import 'package:flutter/material.dart';
// import 'package:olympia/constants/colors.dart';
// import 'package:olympia/constants/fonts.dart';
// import 'package:olympia/view/user/course_detaills_page.dart';

// // ignore: must_be_immutable
// class Courses extends StatelessWidget {
//    Courses({
//     super.key,
//   });
//   List<String>courses=['Karate','Kung Fu','Kick Boxing','MMA','Muay Thai'];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: courses.length,
//       itemBuilder: (context, index) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
//         child: listtile(courses[index],context),
//       );
//     },);
//   }

//   ListTile listtile(String course,BuildContext context) {
//     return ListTile(
//           minTileHeight: 50,
//           leading:  GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CourseDetaillsPage(coursename: course),)),
//           child: Text(course,style: Appfonts.normaltext,)),trailing:  Text('Join',style: Appfonts.normaltext,),
//         tileColor: Appcolors.themecolor,);
//   }
// }
