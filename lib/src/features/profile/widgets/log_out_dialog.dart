import 'package:flutter/material.dart';
import 'package:note_app/src/features/auth/widgets/register_page_controller.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/localization/generated/l10n.dart';
import '../../../common/utils/storage.dart';

class CustomLogOutDialog extends StatelessWidget {
  const CustomLogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = GeneratedLocalization();
    return AlertDialog(
      iconColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      title: Row(
        children: [
          Text(
            localization.logOut,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          const Image(
            width: 25,
            height: 25,
            color: Colors.white,
            image: AssetImage(AppIcons.logOut),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            localization.cancel,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            // await $secureStorage.delete(key: StorageKeys.oneUser.key);
            $storage.setBool("isLogged", false);
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationPageController(),
                ),
                (route) => false,
              );
            }
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
