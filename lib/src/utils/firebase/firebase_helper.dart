import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

Future<String> uploadImageToFirebase(File imageFile,
    {String folder = 'Artisans_Images'}) async {
  try {
    // Create a unique filename for the uploaded image
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload the image to Firebase Storage
    await FirebaseStorage.instance.ref('$folder/$fileName').putFile(imageFile);

    // Get the download URL of the uploaded image
    final String downloadURL = await FirebaseStorage.instance
        .ref('$folder/$fileName')
        .getDownloadURL();
    return downloadURL;
  } catch (e) {
    // Handle any errors
    Logger().e('Error uploading image: $e');
    return '';
  }
}
