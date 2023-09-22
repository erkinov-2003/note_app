import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/models/note_model.dart';
import '../../../common/utils/logger.dart';
import '../../../common/utils/storage.dart';
import '../components/link_dialog.dart';
import '../create_note.dart';
import '../models/link_model.dart';

List<LinkModel> savedLinks = [];

mixin NoteMixin on State<CreateNote> {
  final isDisabled = ValueNotifier<bool>(true);
  final controllerTitle = TextEditingController();
  final controllerBody = TextEditingController();

  int noteId = 0;
  String userId = "0";
  String? title;
  List<LinkModel>? body;
  String? imagePath;
  List<String>? link;
  bool isSecret = false;

  bool isImageSelected = false;
  File? imageFile;

  @override
  void didChangeDependencies() {
    widget.note?.title = controllerTitle.text;

    super.didChangeDependencies();
  }

  void onChanged(String value) {
    isDisabled.value = value.isEmpty;
    String lastWord = controllerBody.text.split(" ").last;
    if (lastWord.isNotEmpty) {
      String word = lastWord;
      savedLinks.add(
        LinkModel(name: word),
      );
    }
  }

  void onSaved() async {
    final noteModel = NoteModel(
      noteId: noteId,
      userId: userId,
      dateTime: DateTime.now(),
      title: controllerTitle.text,
      body: body,
      image: imagePath,
      link: link,
      isSecret: isSecret,
    );

    List<String> notes = $storage.getStringList("notes") ?? [];
    if (widget.note == null) {
      notes.add(jsonEncode(noteModel.toJson()));
      await $storage.setStringList(StorageKeys.notes.key, notes);
    } else {
      int noteIndex = notes.indexOf(jsonEncode(widget.note));
      notes.removeAt(noteIndex);
      notes.insert(noteIndex, jsonEncode(noteModel.toJson()));
    }

    await $storage.setStringList(StorageKeys.notes.key, notes);

    if (body != null) {
      for (int i = 0; i < savedLinks.length - 1; i++) {
        body!.add(savedLinks[i]);
        if (savedLinks[i].name == savedLinks[i + 1].name) {
          body!.removeAt(i + 1);
        }
      }
    }

    notes.add(jsonEncode(noteModel));
    await $storage.setString(StorageKeys.notes.key, jsonEncode(notes));
  }

  FutureOr<String> pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile = File(pickedImage.path);
        isImageSelected = true;
        setState(() {});
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

  FutureOr<String> pickImageFromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile = File(pickedImage.path);
        isImageSelected = true;
        setState(() {});
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

  void openDialogLink() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => LinkDialog(
        controllerBody: controllerBody,
      ),
    );
  }
}
