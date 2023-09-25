import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../../features/splash_screen/models/language_model.dart';
import '../constants/app_icons.dart';

class LangProvider with ChangeNotifier {
  Locale? current;

  Locale getLocale() {
    String key = $storage.getString(StorageKeys.locale.key) ?? "en";
    current = Locale(key);
    return current ?? const Locale("en");
  }
  void changeLocale(Locale newLocale) {
    current = newLocale;
    notifyListeners();
  }

  static List<LanguageModel> languages = const [
    LanguageModel(
      languageName: "English",
      icon: AppIcons.icEng,
      value: "en",
    ),
    LanguageModel(
      languageName: "Russian",
      icon: AppIcons.icRus,
      value: "ru",
    ),
    LanguageModel(
      languageName: "Uzbek",
      icon: AppIcons.icUzb,
      value: "uz",
    ),
  ];
}