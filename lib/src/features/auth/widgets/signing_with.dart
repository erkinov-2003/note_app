import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/translate.dart';
import 'package:note_app/src/common/constants/app_icons.dart';
import 'package:note_app/src/features/auth/widgets/icons_button.dart';

class SignInWith extends StatelessWidget {
  const SignInWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Translate(
          builder: (context, localization, child) {
            return Text(
             localization.signInWith,
              style: const TextStyle(
                fontSize: 14,
              ),
            );
          }
        ),
        const SizedBox(height: 8),
        const SizedBox(
          width: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconsButton(
                image: AppIcons.icApple,
              ),
              IconsButton(
                image: AppIcons.icFacebook,
              ),
              IconsButton(
                image: AppIcons.icTwitter,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
