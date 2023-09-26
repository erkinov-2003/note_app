import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/models/note_model.dart';
import '../../../common/providers/photo_provider.dart';
import '../../home_screen/controller/provider.dart';
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

  bool readOnly = false;
  bool isEditing = false;

  @override
  void didChangeDependencies() {
    context.read<PhotoProvider>().imageFile = ValueNotifier(null);
    final note = widget.note;
    if (note != null) {
      readOnly = true;
      isEditing = true;

      title = note.title;
      body = note.body!;
      imagePath = note.image;

      controllerTitle.text = note.title!;
      controllerBody.text = note.body!.map((e) => e.name).join(" ");
    }

    super.didChangeDependencies();
  }

  void onChanged(String value) {
    isDisabled.value = value.isEmpty;
  }

  void onSaved(Notes notes) async {
    body.clear();
    final list = controllerBody.text.split(" ");
    for (int i = 0; i < list.length; i++) {
      body.add(LinkModel(name: list[i], link: $savedLinks[i + 1]));
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

    print(noteModel);

    if (widget.note == null) {
      notes.addNote(noteModel);
    } else {
      notes.update(widget.note!, noteModel);
    }

    Navigator.pop(context);
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
