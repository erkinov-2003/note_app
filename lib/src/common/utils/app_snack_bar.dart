import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}
