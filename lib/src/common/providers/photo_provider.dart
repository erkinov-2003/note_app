import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/logger.dart';

class PhotoProvider with ChangeNotifier {
  String? imagePath;
  ValueNotifier<bool> isImageSelected = ValueNotifier<bool>(false);
  ValueNotifier<File?> imageFile = ValueNotifier(null);

  FutureOr<String> pickImageFromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile.value = File(pickedImage.path);
        notifyListeners();
        return pickedImage.path;
      } else {
        info("User didn't take any picture.");
      }
    } catch (e, s) {
      shout("$e");
      shout("$s");
    }

    return "";
  }

  FutureOr<String> pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile.value = File(pickedImage.path);
        isImageSelected.value = true;
        notifyListeners();
        return pickedImage.path;
      } else {
        info("User didn't pick any image.");
      }
    } catch (e, s) {
      shout("$e");
      info("$s");
    }
    return "";
  }
}
