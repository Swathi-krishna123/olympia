// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:olympia/constants/colors.dart';
// import 'package:olympia/constants/fonts.dart';

// class Splash2 extends StatefulWidget {
//   const Splash2({super.key});
//   @override
//   State<Splash2> createState() => _Splash2State();
// }

// /////////////////////////////////////////////buttons///////////////////////////////////////////////////
// final List<String> sign = ['SignIn', 'SignUp'];
// final List<String> page = ['/signIn', '/signUp']; //page routes
// //////////////////////////////////////////images///////////////////////////////////////////////////////
// final List<String> imagepaths = [
//   "assets/images/mouythai.jpeg",
//   "assets/images/mma.jpeg",
//   "assets/images/kungfu.jpeg",
//   "assets/images/karatte.jpeg",
//   "assets/images/kickboxing.jpeg"
// ];
// final PageController _pageController = PageController(initialPage: 0);
// Timer? _timer;
// late List<Widget> _pages;
// int _activepage = 0;

// class _Splash2State extends State<Splash2> {
//   void startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) {
//         if (_pageController.page == imagepaths.length - 1) {
//           _pageController.animateToPage(0,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeInOut);
//         } else {
//           _pageController.nextPage(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeInOut);
//         }
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _pages = List.generate(
//       imagepaths.length,
//       (index) => Imageplaceholder(imagepath: imagepaths[index]),
//     );
//     startTimer();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _timer?.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height,
//                 child: PageView.builder(
//                   controller: _pageController,
//                   itemCount: imagepaths.length,
//                   itemBuilder: (context, index) {
//                     return _pages[index];
//                   },
//                   onPageChanged: (value) {
//                     setState(() {
//                       _activepage = value;
//                     });
//                   },
//                 ),
//               ),
//               // add page indicator
//               Positioned(
//                 bottom: 10,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List<Widget>.generate(
//                       _pages.length,
//                       (index) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: InkWell(
//                           onTap: () {
//                             _pageController.animateToPage(index,
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.easeIn);
//                           },
//                           child: CircleAvatar(
//                             radius: 4,
//                             backgroundColor: _activepage == index
//                                 ? Appcolors.themecolor
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               //add signup and sign in buttons
//               Positioned(
//                 bottom: 40,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: List<Widget>.generate(
//                     sign.length,
//                     (index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, page[index]);
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 150,
//                             decoration:
//                                 BoxDecoration(color: Appcolors.primarycolor),
//                             child: Center(
//                                 child: Text(
//                               sign[index],
//                               style: Appfonts.blackbutton,
//                             )),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Imageplaceholder extends StatelessWidget {
//   const Imageplaceholder({super.key, required this.imagepath});
//   final String? imagepath;

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//         opacity: 0.8, child: Image.asset(imagepath!, fit: BoxFit.cover));
//   }
// }
