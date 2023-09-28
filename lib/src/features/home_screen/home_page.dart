import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:provider/provider.dart';

import '../../common/constants/app_colors.dart';
import '../../common/localization/generated/l10n.dart';
import '../../common/models/user_model.dart';
import '../../common/providers/photo_provider.dart';
import '../profile/profile_page.dart';
import 'controller/provider.dart';
import 'widgets/new_note.dart';
import 'widgets/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  User user = User();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  final localization = GeneratedLocalization();

  void read() async {
    String readUser =
        await $secureStorage.read(key: StorageKeys.oneUser.key) ?? "";
    if (readUser.isNotEmpty) {
      user = User.fromJson(readUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    read();

    return Scaffold(
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
              child: ValueListenableBuilder(
                  valueListenable: context.read<PhotoProvider>().imageFile,
                  builder: (context, value, _) {
                    return CircleAvatar(
                      backgroundColor: AppColors.blueGrey,
                      radius: 28,
                      foregroundImage: value != null ? FileImage(value) : null,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: value == null
                            ? const Image(
                                image: AssetImage("assets/images/person.png"),
                              )
                            : null,
                        // child: FutureBuilder(
                        //   future: $secureStorage.read(key: StorageKeys.oneUser.key),
                        //   builder: (context, snapShot) {
                        //     print("=====================================");
                        //     print(snapShot.data);
                        //     User user = User.fromJson(
                        //       jsonDecode(snapShot.data ?? ""),
                        //     )
                        //
                        //     if (snapShot.connectionState == ConnectionState.done &&
                        //         user.image != null) {
                        //       return Image(
                        //         image: FileImage(
                        //           File(user.image!),
                        //         ),
                        //       );
                        //     } else {
                        //       return const Image(
                        //         image: AssetImage("assets/images/person.png"),
                        //       );
                        //     }
                        //   },
                        // ),
                      ),
                    );
                  }),
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
    );
  }
}
