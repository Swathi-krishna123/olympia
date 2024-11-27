// import 'package:flutter/material.dart';
// import 'package:olympia/controller/imgstorageprovider.dart';
// import 'package:provider/provider.dart';

// class Acheivements extends StatefulWidget {
//   Acheivements({
//     super.key,
//   });

//   @override
//   State<Acheivements> createState() => _AcheivementsState();
// }

// class _AcheivementsState extends State<Acheivements> {
//   @override
//   void initState() {
//     // Fetch images when the widget is initialized
//     super.initState();
//     fetchImages();
//   }

//   // Fetch images from the provider
//   Future<void> fetchImages() async {
//     await Provider.of<ImgStorageProvider>(context, listen: false).fetchImages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ImgStorageProvider>(
//       builder: (context, imgstorageprovider, child) {
//         final List<String> imageUrls = imgstorageprovider.imageUrls;

//         return Scaffold(
//           body: ListView.builder(
//             itemCount: imageUrls.length,
//             itemBuilder: (context, index) {
//               // Display each individual image
//               final String imageUrl = imageUrls[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.network(imageUrl),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
