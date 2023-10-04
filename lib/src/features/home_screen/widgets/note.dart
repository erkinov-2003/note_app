import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/src/common/models/note_model.dart';
import 'package:note_app/src/features/create_note/create_note.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants/app_colors.dart';
import 'bottom_sheet.dart';

class Note extends StatefulWidget {
  final NoteModel noteModel;

  const Note({required this.noteModel, super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    parser();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String formatted = "";

  void parser() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    formatted = format.format(widget.noteModel.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        customBottomSheet(
            context: context,
            note: widget.noteModel,
            textEditingController: textEditingController);
        setState(() {});
      },
      onTap: () {
        if (widget.noteModel.isSecret) {
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNote(note: widget.noteModel),
            ),
          );
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.noteModel.title!,
                        style: const TextStyle(
                          fontSize: 27,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: widget.noteModel.body!.map<TextSpan>((e) {
                            if (e.link != null) {
                              return TextSpan(
                                style: const TextStyle(
                                  color: AppColors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                text: "${e.name} ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    String? url = e.link;
                                    if (!url!.startsWith("https://")) {
                                      url = "https://$url";
                                    }
                                    if (!await launchUrl(
                                      Uri.parse(url),
                                      mode: LaunchMode.platformDefault,
                                    )) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                              );
                            } else {
                              return TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                text: "${e.name} ",
                              );
                            }
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      widget.noteModel.image == null
                          ? const SizedBox()
                          : ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              child: Image.file(File(widget.noteModel.image!))),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          Text(
                            formatted,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (widget.noteModel.isSecret)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.noteModel.title ?? " ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  const SizedBox(height: 10),
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
