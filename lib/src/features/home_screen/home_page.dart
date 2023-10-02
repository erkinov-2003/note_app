import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/src/common/constants/app_images.dart';
import 'package:note_app/src/common/models/controller/user_controller.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:provider/provider.dart';

import '../../common/constants/app_colors.dart';
import '../../common/localization/generated/l10n.dart';
import '../profile/profile_page.dart';
import 'controller/notes.dart';
import 'widgets/new_note.dart';
import 'widgets/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final localization = GeneratedLocalization();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: $users.currentUser.notes,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 80,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.blue,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Consumer<Users>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: value.currentUser.image == null
                              ? const Image(
                                  fit: BoxFit.cover,
                                  height: 40,
                                  image: AssetImage(AppImages.person),
                                )
                              : Image.file(
                                  fit: BoxFit.cover,
                                  File($users.currentUser.image!),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Note.d",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                localization.enjoyNote,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        body: Consumer<Notes>(
          builder: (context, value, child) {
            return MasonryGridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              itemCount: value.allNotes.length + 1,
              itemBuilder: (context, index) {
                return index == 0
                    ? const CustomNewNote()
                    : Note(
                        noteModel: value.allNotes[index - 1],
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
