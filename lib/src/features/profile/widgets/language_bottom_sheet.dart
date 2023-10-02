import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/translate.dart';
import 'package:note_app/src/features/splash_screen/models/language_model.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/providers/lang_provider.dart';
import '../../../common/utils/storage.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                Translate(builder: (context, localization, child) {
                  return Text(
                    localization.language,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
                const SizedBox(width: 20),
                Image(
                  image: const AssetImage(AppIcons.globe),
                  color: Theme.of(context).primaryColor,
                  height: 20,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon:  Icon(
                    Icons.cancel,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<LangProvider>(
            builder: (context, value, child) => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                String locale = switch (index) {
                  0 => "en",
                  1 => "ru",
                  2 => "uz",
                  _ => "en",
                };
                LanguageModel lang = LangProvider.languages.elementAt(index);
                return ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hoverColor: AppColors.airColor.withOpacity(0.2),
                  splashColor: AppColors.airColor,
                  tileColor: locale == value.current.languageCode
                      ? AppColors.selectedLanguageColor
                      : AppColors.unSelectedLanguageColor,
                  onTap: () async {
                    value.changeLocale(Locale(locale));
                    await $storage.setString(StorageKeys.locale.key, locale);
                    if (context.mounted) Navigator.pop(context);
                  },
                  title: Text(
                    lang.languageName,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage(lang.icon),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
