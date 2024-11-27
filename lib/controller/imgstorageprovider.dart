import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgStorageProvider with ChangeNotifier {
  //firebase storage

  final firebaseStorage = FirebaseStorage.instance;

  //images are stored in firebase as download URLS
  List<String> _imageUrls = [];

  //loading status
  bool _isLoading = false;

  //uploading status

  bool _isUploading = false;

  /* 
  G E T T E R S
  */
  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  /* 


  R E A D   I M G E S

  */

  Future<void> fetchImages() async {
  // Start loading
  _isLoading = true;
  notifyListeners();

  try {
    // Get the list of all files in the directory 'upload_images/'
    final ListResult result = await firebaseStorage.ref('upload_images/').listAll();

    // Fetch metadata for each image and sort by creation time
    final itemsWithMetadata = await Future.wait(result.items.map((ref) async {
      final metadata = await ref.getMetadata();
      final downloadUrl = await ref.getDownloadURL();
      return {'url': downloadUrl, 'timeCreated': metadata.timeCreated};
    }));

    // Sort the images by creation date in reverse order (latest first)
    itemsWithMetadata.sort((a, b) {
      final timeA = a['timeCreated'] as DateTime;
      final timeB = b['timeCreated'] as DateTime;
      return timeB.compareTo(timeA); // Latest first
    });

    // Extract sorted URLs
    _imageUrls = itemsWithMetadata.map((item) => item['url'] as String).toList();
  } catch (e) {
    print('Error fetching images: $e');
  } finally {
    // Loading finished
    _isLoading = false;
    notifyListeners();
  }
}


  /* 
  
   D E L E T E   I M G E 
  - images are stored as download URLs. Eg,
  eg : https:/firebasestorage.googleapis.com/v0/b/fir-masterclass....../uploaded_images/image_name.png/...
  -in order to delete ,we need to know only the path of this image store in firebase 
  ie : uploaded_images/image_name.png

  */
  Future<void> deleteImage(String imageUrl) async {
    try{
      // remove from local list 
      _imageUrls.remove(imageUrl);

      // get the path name  and delete  from firebase 
      final String path = extractPathFromUrl(imageUrl);
      await  firebaseStorage.ref(path).delete();
    } 
    // handle any errors
    catch (e){
      print("erorr deleting image : $e");

    }
    // update UI
    notifyListeners();
  }

  String extractPathFromUrl(String url){
    Uri uri = Uri.parse(url);

    // extracting  the part of the url we need
    String encodedpath = uri.pathSegments.last;

    // url decoding  the  path 
    return Uri.decodeComponent(encodedpath);
  }


  /* 

  U P L O A D  I M A G E 
  
  */
  Future <void >uploadImage() async{
    // start uploading...
    _isUploading=true;
    // update UI
    notifyListeners();

    // pick an image

    final ImagePicker picker=ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if( image  == null ) return ;// user  cancelled  the picker 

    File  file=File(image.path);
    try{
      // define the path in storage
      String filepath = 'upload_images/${DateTime.now()}.png';
      // upload the file to firebase storage
      await firebaseStorage.ref(filepath).putFile(file);
      // after uplioading ...fetch  the downloading URL
      String downloadUrl = await firebaseStorage.ref(filepath).getDownloadURL();
      //udate the image list and ui
      _imageUrls.insert(0,downloadUrl);
      notifyListeners();
    }catch (e){
      print("Error uploading..$e");
    }finally{
      _isUploading=false;
      notifyListeners();
    }
  }
}
