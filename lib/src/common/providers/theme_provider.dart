import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../constants/app_colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode;
  late bool isDark;

  ThemeProvider({ThemeMode? themeMode})
      : themeMode = themeMode ?? ThemeMode.system;

  void changeTheme(bool mode) {
    $storage.setBool(StorageKeys.theme.key, !mode);
    notifyListeners();
  }

  ThemeMode getTheme() {
    isDark = $storage.getBool(StorageKeys.theme.key) ?? true;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    return themeMode;
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
    colorScheme: const ColorScheme.dark(background: Color(0xFF262629))
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
    cardColor: const Color(0x4DDEDEDF),

      colorScheme: const ColorScheme.light(background: Color(0xFFBDBDBD))
  );
}
