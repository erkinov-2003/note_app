import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        backgroundColor: AppColors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.black,
          toolbarHeight: 80,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 57,
                  height: 57,
                  child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                      ),
                      child: Consumer<Users>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: value.currentUser.image == null
                                ? const Image(
                                    image:
                                        AssetImage("assets/images/person.png"),
                                  )
                                : Image.file(
                                    File($users.currentUser.image!),
                                  ),
                          );
                        },
                      )),
                ),
              ),
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Note.d",
                style: TextStyle(color: AppColors.white, fontSize: 24),
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
                    ? CustomNewNote()
                    : Note(noteModel: value.allNotes[index - 1]);
              },
            );
          },
        ),
      ),
    );
  }
}
