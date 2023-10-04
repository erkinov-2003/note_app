import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common/localization/generated/l10n.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';

class NameDialog extends StatefulWidget {
  final ValueNotifier<String> name;
  const NameDialog({
    required this.name,
    super.key,
  });

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  late final TextEditingController nameController;
  User user = User();

  final localization = GeneratedLocalization();

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final User first=User(name:GeneratedLocalization.of(context).yourName);
    nameController.text = $users.currentUser.name ?? "";
    // user = User.fromJson(jsonDecode(
    //     await $secureStorage.read(key: StorageKeys.oneUser.key) ??
    //         jsonEncode(first.toJson()),),);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: Text(
        localization.changeYourName,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceAround,

      actions: [
        TextField(
          autofocus: true,
          controller: nameController,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            localization.cancel,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF575758),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            $users.updateUser($users.currentUser.copyWith(name: nameController.text));
            widget.name.value = nameController.text;
            Navigator.pop(context);
          },
          child: Text(
            localization.save,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFFF0000),
            ),
          ),
        ),
      ],
    );
  }
}
