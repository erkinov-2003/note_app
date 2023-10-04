import 'package:flutter/material.dart';
import 'package:note_app/src/common/models/note_model.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/features/secret_notes/new_pass.dart';

Object customBottomSheet({
  required TextEditingController textEditingController,
  required BuildContext context,
  required NoteModel note,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 87, 87, 88),
                    fixedSize: const Size(340, 48),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    if ($users.currentUser.secretPassword == null) {
                      final bool? isTrue = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewSecretPassword(),
                        ),
                      );
                      if (isTrue ?? false) {
                        $users.currentUser.notes!.changeSecure(note);
                      }
                    } else {
                      if (note.isSecret) {
                        Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewSecretPassword(
                              note: note,
                            ),
                          ),
                        );
                      } else {
                        $users.currentUser.notes!.changeSecure(note);
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        $users.currentUser.secretPassword == null
                            ? "Add Password"
                            : note.isSecret
                                ? "Unlock"
                                : "Lock",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage("assets/icons/lock.png"),
                          height: 24,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future:
                      $secureStorage.read(key: StorageKeys.notesPassword.key),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 87, 87, 88),
                          fixedSize: const Size(340, 48),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          if (note.isSecret) {
                            Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewSecretPassword(
                                    note: note, isChecked: true),
                              ),
                            );
                          } else {
                            $users.currentUser.notes!.delete(note);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 21,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
