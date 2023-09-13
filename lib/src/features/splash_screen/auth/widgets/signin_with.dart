import 'package:flutter/material.dart';

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
            color: Color(0xFF575758),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconsButton(
                image: "assets/images/apple.png",
              ),
              IconsButton(
                image: "assets/images/facebook.png",
              ),
              IconsButton(
                image: "assets/images/twitter.png",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
