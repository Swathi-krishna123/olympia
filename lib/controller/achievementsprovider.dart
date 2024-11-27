import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Achievementsprovider extends ChangeNotifier {
  List<File> images = []; // List to hold paths for local images
  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print("Image path: ${pickedImage.path}"); // Debugging: Check image path
      images.insert(
          0, File(pickedImage.path)); // Add the selected image to the list
    }
    notifyListeners();
  }

  void deleteImage(int index) {
    images.removeAt(index); // Remove the image at the given index
  notifyListeners();
  }
}
