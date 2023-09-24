import 'package:flutter/material.dart';
import 'package:note_app/src/common/models/note_model.dart';
import 'package:note_app/src/common/utils/storage.dart';

Object customBottomSheet(
  BuildContext context,
  NoteModel note,
) {
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
                    return value
                        ? TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if(!note.isSecret) {
                                    $notes.changeSecure(note);
                                  }else {
                                    $notes.changeSecureSet(note);
                                  }
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.done,color: Colors.green,),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  image: AssetImage("assets/icons/lock.png"),
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
      );
    },
  );
}
