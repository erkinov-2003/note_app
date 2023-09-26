import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import 'icons_button.dart';

class SignInWith extends StatelessWidget {
  const SignInWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Sign in with ",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
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
