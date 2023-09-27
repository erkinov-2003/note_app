import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData currentTheme;
  ThemeMode themeMode;

  ThemeProvider({ThemeMode? themeMode})
      : themeMode = themeMode ?? ThemeMode.system;

  void changeTheme(bool mode) {
    themeMode = switch (mode) {
      false => ThemeMode.dark,
      true => ThemeMode.light,
    };
    notifyListeners();
  }

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.white,
    primaryTextTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleMedium: TextStyle(
          color: AppColors.white,
        )),
    useMaterial3: true,
    fontFamily: "Ranade",
    cardColor: const Color(0xFF1A1A1B),
    colorScheme: ColorScheme.dark(background: Color(0xFF262629))
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.black,
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        color: AppColors.black,
      ),
    ),
    useMaterial3: true,
    fontFamily: "Ranade",
    cardColor: Color(0x4DDEDEDF),

      colorScheme: ColorScheme.light(background: Color(0xFFBDBDBD))
  );
}
