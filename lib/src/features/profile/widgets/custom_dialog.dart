import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../../../common/constants/app_icons.dart';

class CustomLogOutDialog extends StatelessWidget {
  const CustomLogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: const Row(
        children: [
          Text(
            "Log out",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 20),
          Image(
            width: 25,
            height: 25,
            color: Colors.black,
            image: AssetImage(AppIcons.logOut),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF575758),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            $storage.remove("user");
            Navigator.pop(context);
          },
          child: const Text(
            "Log out",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFFF0000),
            ),
          ),
        ),
      ],
    );
  
  }
}
