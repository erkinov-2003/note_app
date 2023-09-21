import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../mixin/note_mixin.dart';
import '../models/link_model.dart';

class LinkDialog extends StatefulWidget {
  final TextEditingController controllerBody;

  const LinkDialog({
    required this.controllerBody,
    super.key,
  });

  @override
  State<LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  late final TextEditingController controllerLink;
  late final TextEditingController controllerLinkName;

  @override
  void initState() {
    controllerLink = TextEditingController();
    controllerLinkName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerLink.dispose();
    controllerLinkName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: size.width * 0.85,
        height: size.height * 0.3,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
            horizontal: size.width * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Text with link",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width * 0.72,
                height: size.height * 0.07,
                child: TextField(
                  controller: controllerLink,
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Paste Text",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.72,
                height: size.height * 0.07,
                child: TextField(
                  controller: controllerLinkName,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.cyan),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Paste Link",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.cyan,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      String temp = widget.controllerBody.text.trim();
                      temp += " ${controllerLink.text} ";
                      widget.controllerBody.text = temp;
                      savedLinks.add(
                        LinkModel(
                          link: controllerLink.text,
                          name: controllerLinkName.text,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Add Link",
                      style: TextStyle(
                          color: Color(0xFF36BFFA),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
