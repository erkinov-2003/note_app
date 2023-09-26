import 'package:flutter/material.dart';

import '../../../common/models/note_model.dart';
import '../../../common/utils/storage.dart';

Object customBottomSheet({
  required TextEditingController textEditingController,
  required BuildContext context,
  required NoteModel note,
}) {

  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  return showBottomSheet(
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
              )
            ),
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
                  onPressed: () {
                    isChecked.value = true;
                  },
                  child: ValueListenableBuilder(
                    valueListenable: isChecked,
                    builder: (context, value, child) {
                      return note.isSecret
                          ? TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    String? password =
                                        await $secureStorage.read(key: "ass");
                                    if (textEditingController.text == password &&
                                        password != null) {
                                      if (!note.isSecret) {
                                        $notes.changeSecure(note);
                                      } else {
                                        $notes.changeSecureSet(note);
                                      }
                                    } else {
                                      SnackBar text = SnackBar(
                                        content: const Text(
                                          "You entered the password incorrectly",
                                          style: TextStyle(fontSize: 20,color: Colors.black),
                                        ),
                                        backgroundColor: Colors.white,
                                        dismissDirection: DismissDirection.up,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.sizeOf(context).height - 120,
                                          left: 10,
                                          right: 10,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(text);
                                    }
                                    textEditingController.clear();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            )
                          : value
                              ? TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        if (!note.isSecret) {
                                          $notes.changeSecure(note);
                                        } else {
                                          $notes.changeSecureSet(note);
                                        }
                                        textEditingController.clear();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Add Password",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      icon: const Image(
                                        image:
                                            AssetImage("assets/icons/lock.png"),
                                        height: 24,
                                      ),
                                    )
                                  ],
                                );
                    },
                  ),
                ),
                const SizedBox(height: 10),
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
                  onPressed: () {
                    $notes.removeNote(note);
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
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
