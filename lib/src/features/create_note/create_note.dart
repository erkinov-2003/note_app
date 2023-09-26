import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/localization/generated/l10n.dart';
import '../../common/models/note_model.dart';
import '../../common/providers/photo_provider.dart';
import '../../common/providers/theme_provider.dart';
import '../home_screen/controller/provider.dart';
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
    final intl = GeneratedLocalization.of(context);
    final provider = context.read<PhotoProvider>();
    final theme = Theme.of(context);

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
        title: Text(
          intl.back,
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 16.5,
          ),
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
            onTap: () async {
              imagePath = await showModalBottomSheet(
                context: context,
                builder: (context) => const CameraBottomSheet(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image(
                color: theme.primaryColor,
                image: const AssetImage(AppIcons.icGallery),
              ),
            ),
          ),
          GestureDetector(
            onTap: openDialogLink,
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
                valueListenable: provider.imageFile,
                builder: (context, value, _) {
                  return value != null
                      ? Image(
                          fit: BoxFit.cover,
                          image: FileImage(value),
                        )
                      : const SizedBox.shrink();
                }),
            ValueListenableBuilder(
                valueListenable: isDisabled,
                builder: (context, value, _) {
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
                    decoration: const InputDecoration(
                      helperStyle: TextStyle(color: Colors.transparent),
                      border: InputBorder.none,
                      hintText: "Enter title of note...",
                      hintStyle: TextStyle(
                        color: AppColors.iconColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }),
            ValueListenableBuilder(
              valueListenable: isDisabled,
              builder: (context, value, child) {
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
                  maxLines: value || controllerBody.text.isEmpty ? 5 : null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        "This is where your note will be. It’ll be housed here. You’ll save your note here. Type your memories here. Write down your thoughts.",
                    hintStyle: TextStyle(
                      color: AppColors.iconColor,
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
