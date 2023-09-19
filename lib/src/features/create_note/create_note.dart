import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import 'mixin/note_mixin.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> with NoteMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: Theme(
          data: ThemeData(
            splashColor: AppColors.transparent,
          ),
          child: const BackButton(
            color: AppColors.black,
          ),
        ),
        leadingWidth: 40,
        title: const Text(
          "Back",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.5,
          ),
        ),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              await pickImageFromGallery();
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage(AppIcons.icGallery),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage(AppIcons.icLink),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: isDisabled,
        builder: (context, value, child) {
          return SizedBox.square(
            dimension: 75,
            child: FloatingActionButton(
              onPressed: () => onSaved,
              shape: const CircleBorder(),
              backgroundColor:
                  value ? AppColors.colorFAB1 : AppColors.colorFAB0,
              child: const Image(
                width: 40,
                height: 40,
                image: AssetImage(AppIcons.icSave),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ValueListenableBuilder(
                valueListenable: isDisabled,
                builder: (context, value, child) {
                  return TextField(
                    onChanged: onChanged,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 32,
                      decorationThickness: 0,
                    ),
                    cursorColor: AppColors.transparent,
                    cursorHeight: 50,
                    textAlignVertical: TextAlignVertical.center,
                    cursorRadius: const Radius.circular(10),
                    maxLines: 4,
                    minLines: 1,
                    maxLength: 60,
                    decoration: const InputDecoration(
                      helperStyle: TextStyle(color: Colors.transparent),
                      border: InputBorder.none,
                      hintText: "Enter title of note...",
                      hintStyle: TextStyle(
                        color: Color(0xFFE4E7EC),
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }),
            ValueListenableBuilder(
              valueListenable: isDisabled,
              builder: (context, value, child) {
                return TextField(
                  controller: controller,
                  onChanged: onChanged,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                    decorationThickness: 0,
                  ),
                  keyboardType: TextInputType.multiline,
                  cursorColor: AppColors.transparent,
                  cursorRadius: const Radius.circular(5),
                  maxLines: value || controller.text.isEmpty ? 5 : null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        "This is where your note will be. It’ll be housed here. You’ll save your note here. Type your memories here. Write down your thoughts.",
                    hintStyle: TextStyle(
                      color: AppColors.hintColor,
                      fontSize: 18,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
