import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/common/utils/translate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/models/note_model.dart';
import '../home_screen/controller/notes.dart';
import '../profile/widgets/camera_dialog.dart';
import 'mixin/note_mixin.dart';

class CreateNote extends StatefulWidget {
  final NoteModel? note;

  const CreateNote({
    this.note,
    super.key,
  });

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> with NoteMixin {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: $users.currentUser.notes,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: Theme(
              data: ThemeData(
                splashColor: AppColors.transparent,
              ),
              child: BackButton(
                color: theme.primaryColor,
              ),
            ),
            leadingWidth: 40,
            title: Translate(
              builder: (context, localization, child) {
                return Text(
                  localization.back,
                  style: const TextStyle(
                    fontSize: 16.5,
                  ),
                );
              },
            ),
            titleSpacing: 0,
            actions: [
              isEditing
                  ? GestureDetector(
                      onTap: () => setState(() => readOnly = false),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.edit_note,
                          color: theme.primaryColor,
                          size: 38,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              GestureDetector(
                onTap: !readOnly
                    ? () async {
                        imagePath = await showModalBottomSheet<String?>(
                          context: context,
                          elevation: 0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          showDragHandle: true,
                          builder: (context) => const CameraBottomSheet(),
                        );
                        image.value = imagePath ?? image.value;

                      }
                    : () {},
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image(
                    color: theme.primaryColor,
                    image: const AssetImage(AppIcons.icGallery),
                  ),
                ),
              ),
              GestureDetector(
                onTap: !readOnly ? openDialogLink : () {},
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image(
                    color: theme.primaryColor,
                    image: const AssetImage(AppIcons.icLink),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: ValueListenableBuilder(
            valueListenable: isDisabled,
            builder: (context, value, _) {
              return SizedBox.square(
                dimension: 75,
                child: Consumer<Notes>(
                  builder: (context, model, child) {
                    return FloatingActionButton(
                      onPressed: () => onSaved(model),
                      shape: const CircleBorder(),
                      backgroundColor:
                          value ? AppColors.colorFAB1 : AppColors.white,
                      child: Image(
                        width: 40,
                        height: 40,
                        color: value ? AppColors.white : AppColors.black,
                        image: const AssetImage(AppIcons.icSave),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ValueListenableBuilder(
                    valueListenable: image,
                    builder: (context, value, _) {
                      return value != null
                          ? Image(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(value),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                ValueListenableBuilder(
                    valueListenable: isDisabled,
                    builder: (context, value, _) {
                      return Translate(builder: (context, localization, child) {
                        return TextField(
                          controller: controllerTitle,
                          readOnly: readOnly,
                          onChanged: onChanged,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 30,
                            decorationThickness: 0,
                          ),
                          cursorColor: theme.primaryColor,
                          cursorHeight: 50,
                          textAlignVertical: TextAlignVertical.center,
                          cursorRadius: const Radius.circular(10),
                          maxLines: 4,
                          minLines: 1,
                          maxLength: 60,
                          decoration: InputDecoration(
                            helperStyle:
                            const TextStyle(color: Colors.transparent),
                            border: InputBorder.none,
                            hintText: localization.enterTitle,
                            hintStyle: const TextStyle(
                              color: AppColors.iconColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },);
                    }),
                ValueListenableBuilder(
                  valueListenable: isDisabled,
                  builder: (context, value, child) {
                    return !readOnly
                        ? Translate(
                          builder: (context, localization, child) {
                            return TextField(
                                controller: controllerBody,
                                readOnly: readOnly,
                                onChanged: onChanged,
                                textCapitalization: TextCapitalization.sentences,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: theme.primaryColor,
                                  decorationThickness: 0,
                                ),
                                keyboardType: TextInputType.multiline,
                                cursorColor: theme.primaryColor,
                                cursorRadius: const Radius.circular(5),
                                maxLines:
                                    value || controllerBody.text.isEmpty ? 5 : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: localization.bodyText,
                                  hintStyle: const TextStyle(
                                    color: AppColors.iconColor,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                          }
                        )
                        : RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 18),
                              children: body.map<TextSpan>((e) {
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
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                  );
                                } else {
                                  return TextSpan(
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                    ),
                                    text: "${e.name} ",
                                  );
                                }
                              }).toList(),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
