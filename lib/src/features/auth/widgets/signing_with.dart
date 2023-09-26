import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/localization/generated/l10n.dart';
import 'icons_button.dart';

class SignInWith extends StatelessWidget {
  SignInWith({Key? key}) : super(key: key);

  final localization = GeneratedLocalization();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
         localization.signInWith,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textColor,
          ),
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
