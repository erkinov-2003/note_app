import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../create_note.dart';

mixin NoteMixin on State<CreateNote> {
  final isDisabled = ValueNotifier<bool>(true);
  final controller = TextEditingController();

  void onChanged(String value) => isDisabled.value = value.isEmpty;

  void onSaved() => Navigator.pop(context);

  bool isImageSelected = false;
  File? imageFile;

  pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
