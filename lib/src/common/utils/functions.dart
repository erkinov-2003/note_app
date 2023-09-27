import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';
import 'package:note_app/src/common/utils/logger.dart';

GeneratedLocalization translate(BuildContext context) => GeneratedLocalization.of(context);

Future<String?> pickImageFromCamera() async {
  try {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      return pickedImage.path;
    } else {
      return null;
    }
  } catch (e, s) {
    shout("$e");
    shout("$s");
  }
  return null;
}

Future<String?> pickImageFromGallery() async {
  try {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    } else {
      return null;
    }
  } catch (e, s) {
    shout("$e");
    info("$s");
  }
  return null;
}