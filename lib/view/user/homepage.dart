// import 'package:flutter/material.dart';
// import 'package:olympia/constants/colors.dart';
// import 'package:olympia/constants/fonts.dart';
// import 'package:olympia/constants/icons.dart';
// import 'package:olympia/view/user/acheivements.dart';
// import 'package:olympia/view/user/courses.dart';

// class Homepage extends StatelessWidget {
//   const Homepage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Olympia',
//             style: Appfonts.olympia
//           ),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/notification');
//                 },
//                 icon: Icon(
//                   Appicons.notification,
//                   size: 28,
//                 )),
//             IconButton(
//                 onPressed: () {
//                 },
//                 icon: Icon(
//                   Appicons.menu,
//                   size: 28,
                  
//                 )),
//             const SizedBox(
//               width: 10,
//             )
//           ],
//           bottom: TabBar(
//             indicatorColor: Appcolors.primarycolor,
//             dividerColor: Colors.transparent,
//             labelStyle: Appfonts.normalheading,
//             overlayColor: WidgetStatePropertyAll(Appcolors.themecolor),
          
//             tabs: const <Widget>[
//               Tab(
//                 text: 'Achievements',
//               ),
//               Tab(
//                 text: 'Courses',
//               ),
//             ],
//           ),
//         ),
//         body: SizedBox(
//           child: TabBarView(children: [Acheivements(), Courses()]),
//         ),
//       ),
//     );
//   }
// }


