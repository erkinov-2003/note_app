import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/src/features/home_screen/controller/provider.dart';

import '../../../common/models/note_model.dart';
import '../../../common/utils/logger.dart';
import '../components/link_dialog.dart';
import '../create_note.dart';
import '../models/link_model.dart';

Map<int, String> $savedLinks = {};

mixin NoteMixin on State<CreateNote> {
  final isDisabled = ValueNotifier<bool>(true);
  final controllerTitle = TextEditingController();
  final controllerBody = TextEditingController();

  int noteId = 0;
  String userId = "0";
  String? title;
  List<LinkModel> body = [];
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
  }

  void onSaved(Notes notes) async {

      final list = controllerBody.text.split(" ");
      for(int i = 0; i < list.length; i++) {
        body.add(LinkModel(name: list[i],link: $savedLinks[i+1]));
      }

      $savedLinks.clear();

    final noteModel = NoteModel(
      noteId: noteId,
      userId: userId,
      title: controllerTitle.text,
      body: body,
      image: imagePath,
      link: link,
      isSecret: isSecret,
    );

    if (widget.note == null) {
      notes.addNote(noteModel);
    } else {
      notes.update(widget.note!.noteId, noteModel);
    }

    Navigator.pop(context);
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
