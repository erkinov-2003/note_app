import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/src/common/constants/app_images.dart';
import 'package:note_app/src/common/models/note_model.dart';

import '../../../common/constants/app_colors.dart';

class Note extends StatefulWidget {
  final NoteModel noteModel;

  const Note({required this.noteModel, super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  void initState() {
    parser();
    super.initState();
  }

  String formatted = "";

  void parser() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    formatted = format.format(widget.noteModel.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.white,strokeAlign: BorderSide.strokeAlignOutside),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.noteModel.title!,
                    style: const TextStyle(
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.noteModel.body!,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  widget.noteModel.image == null
                      ? const SizedBox()
                      : Image(
                          image: AssetImage(widget.noteModel.image!),
                        ),
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatted,
                        style: const TextStyle(color: AppColors.white),
                      ),
                      widget.noteModel.isSecret
                          ? Image.asset(
                              AppImages.lock,
                              color: AppColors.white,
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ),
            ),
            if (widget.noteModel.isSecret)
              Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                    child: SizedBox.expand(
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
                                style: const TextStyle(color: Colors.white, fontSize: 25),
                              ),
                              const SizedBox(height: 10),
                              const Icon(Icons.lock),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
