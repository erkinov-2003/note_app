import 'package:flutter/material.dart';

import '../../features/splash_screen/models/language_model.dart';
import '../constants/app_icons.dart';
import '../utils/storage.dart';

class LangProvider with ChangeNotifier {
  late Locale current;

  Locale getLocale() {
    String key = $storage.getString(StorageKeys.locale.key) ?? "en";
    current = Locale(key);
    return current;
  }
  void changeLocale(Locale newLocale) {
    $storage.setString(
        StorageKeys.locale.key, newLocale.languageCode);
    notifyListeners();
  }

  static List<LanguageModel> languages = const [
    LanguageModel(
      languageName: "English",
      icon: AppIcons.icEng,
      value: "en",
    ),
    LanguageModel(
      languageName: "Русский",
      icon: AppIcons.icRus,
      value: "ru",
    ),
    LanguageModel(
      languageName: "O'zbek",
      icon: AppIcons.icUzb,
      value: "uz",
    ),
  ];
}