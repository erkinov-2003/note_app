import 'package:flutter/material.dart';
import 'package:note_app/src/features/auth/widgets/registration_page.dart';

import '../../../common/constants/app_icons.dart';
import '../../../common/localization/generated/l10n.dart';
import '../../../common/utils/storage.dart';
import '../../auth/widgets/registr_page_controller.dart';

class CustomLogOutDialog extends StatelessWidget {
  const CustomLogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = GeneratedLocalization();
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: Row(
        children: [
          Text(
            localization.logOut,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 20),
          const Image(
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
          onPressed: () async {
            await $secureStorage.delete(key: StorageKeys.oneUser.key);
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationPageController(),
                ));
          },
          child: Text(
            localization.logOut,
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
