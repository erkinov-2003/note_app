import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/src/common/constants/app_images.dart';

import '../../../common/constants/app_colors.dart';

class Note extends StatefulWidget {
  final String title;
  final String subTitle;
  final String? path;
  final bool isLogget;
  final DateTime dateTime;

  const Note({
    Key? key,
    this.path,
    required this.title,
    required this.subTitle,
    this.isLogget = false,
    required this.dateTime,
  }) : super(key: key);

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
    formatted = format.format(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.subTitle,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.white, fontSize: 15),
              ),
              const SizedBox(height: 10),
              widget.path == null
                  ? const SizedBox()
                  : Image(
                      image: AssetImage(widget.path!),
                    ),
              const SizedBox(height: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatted,
                    style: const TextStyle(color: AppColors.white),
                  ),
                  widget.isLogget
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
      ),
    );
  }
}
