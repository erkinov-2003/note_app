import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final isDisabled = ValueNotifier<bool>(true);

  void onChanged(String value) => isDisabled.value = value.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
          ),
          child: const BackButton(
            color: Color(0xFF000000),
          ),
        ),
        leadingWidth: 40,
        title: const Text(
          "Back",
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 16.5,
          ),
        ),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage("assets/images/ic_image.png"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage("assets/images/ic_link.png"),
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
              onPressed: () {},
              backgroundColor:
                  value ? const Color(0xFFD0D5DD) : const Color(0xFF000000),
              child: const Image(
                width: 40,
                height: 40,
                image: AssetImage("assets/images/ic_save.png"),
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
                      fontSize: 32,
                    ),
                    cursorColor: const Color(0x00000000),
                    cursorHeight: 40,
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
                  onChanged: onChanged,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.multiline,
                  cursorColor: const Color(0x00000000),
                  cursorRadius: const Radius.circular(5),
                  maxLines: value ? 6 : null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        "This is where your note will be. It’ll be housed here. You’ll save your note here. Type your memories here. Write down your thoughts.",
                    hintStyle: TextStyle(
                      color: Color(0xFFE4E7EC),
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
