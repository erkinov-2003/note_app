import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/src/common/models/note_model.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../create_note.dart';

mixin NoteMixin on State<CreateNote> {
  final isDisabled = ValueNotifier<bool>(true);
  final controllerTitle = TextEditingController();
  final controllerBody = TextEditingController();
  String? imagePath;
  String? link;
  bool isSecret = false;

  void onChanged(String value) => isDisabled.value = value.isEmpty;

  @override
  void didChangeDependencies() {
    widget.note?.title = controllerTitle.text;
    widget.note?.body = controllerBody.text;

    super.didChangeDependencies();
  }

  void onSaved() async {
    final noteModel = NoteModel(
      dateTime: DateTime.now(),
      image: imagePath,
      title: controllerTitle.text,
      body: controllerBody.text,
      link: link,
      isSecret: isSecret,
    );
    List<String> notes = $storage.getStringList("notes") ?? [];
    if (widget.note == null) {
      notes.add(jsonEncode(noteModel.toJson()));
      await $storage.setStringList("notes", notes);
    } else {
      int noteIndex = notes.indexOf(jsonEncode(widget.note));
      notes.removeAt(noteIndex);
      notes.insert(noteIndex, jsonEncode(noteModel.toJson()));
    }
    await $storage.setStringList("notes", notes);
    Navigator.pop(context);
  }

  // bool isImageSelected = false;
  // File? imageFile;

  FutureOr<String> pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        // imageFile = File(pickedImage.path);
        // isImageSelected = true;
        imagePath = pickedImage.path;
        return pickedImage.path;
      } else {
        print("User didn't pick any image.");
      }
    } catch (e) {
      print(e.toString());
    }

    return "";
  }
}
