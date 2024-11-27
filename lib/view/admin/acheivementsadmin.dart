import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/controller/imgstorageprovider.dart';
import 'package:olympia/controller/user_provider.dart';
import 'package:provider/provider.dart';

class AcheivementsAdmin extends StatefulWidget {
  const AcheivementsAdmin({
    super.key,
  });

  @override
  State<AcheivementsAdmin> createState() => _AcheivementsAdminState();
}

class _AcheivementsAdminState extends State<AcheivementsAdmin> {
  @override
  void initState() {
    super.initState();
    // Fetch images on screen load
    fetchImages();
    // Check admin status on screen load
    Provider.of<UserProvider>(context, listen: false).checkAdminStatus();
  }

  // Fetch images from the provider
  Future<void> fetchImages() async {
    await Provider.of<ImgStorageProvider>(context, listen: false).fetchImages();
  }

  // Show delete confirmation dialog for admin users
  Future<void> _showDeleteDialog(String imageUrl) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Image',
            style: Appfonts.normalheading,
          ),
          content: Text(
            'Are you sure you want to delete this image?',
            style: Appfonts.normaltext,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: Appfonts.subheading1,
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ImgStorageProvider>(context, listen: false)
                    .deleteImage(imageUrl); // Call delete function from provider
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Consumer<ImgStorageProvider>(
      builder: (context, imgstorageprovider, child) {
        final List<String> imageUrls = imgstorageprovider.imageUrls;

        return Scaffold(
          floatingActionButton: userProvider.isAdmin
              ? FloatingActionButton(
                  backgroundColor: Appcolors.themecolor,
                  foregroundColor: Appcolors.primarycolor,
                  onPressed: () => imgstorageprovider.uploadImage(),
                  child: const Icon(Icons.add),
                )
              : null,
          body: ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              final String imageUrl = imageUrls[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onDoubleTap: userProvider.isAdmin
                      ? () => _showDeleteDialog(imageUrl)
                      : null,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      } else {
                        return child;
                      }
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
