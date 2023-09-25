import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/src/common/providers/lang_provider.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/app_images.dart';
import '../models/language_model.dart';

class LanguageChangerPage extends StatefulWidget {
  const LanguageChangerPage({super.key});

  @override
  State<LanguageChangerPage> createState() => _LanguageChangerPageState();
}

class _LanguageChangerPageState extends State<LanguageChangerPage> {
  late List<LanguageModel> languages;
  late Locale selectedLocale;

  @override
  void initState() {
    super.initState();
    languages = LangProvider.languages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 35,
            left: 35,
            right: 35,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Language APP",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Image(
                    image: AssetImage(AppImages.languageBgImage),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: Builder(builder: (context) {
                  final LangProvider langProvider =
                      Provider.of<LangProvider>(context, listen: false);
                  return CupertinoPicker(
                    magnification: 1.3,
                    useMagnifier: true,
                    itemExtent: 50,
                    selectionOverlay: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Divider(),
                          Divider(),
                        ],
                      ),
                    ),
                    scrollController: FixedExtentScrollController(
                        initialItem: switch (
                            langProvider.current?.languageCode) {
                      "en" => 0,
                      "ru" => 1,
                      "uz" => 2,
                      _ => -1,
                    }),
                    onSelectedItemChanged: (int selectedItem) {
                      final selectedLocale = languages[selectedItem];
                      langProvider.changeLocale(Locale(selectedLocale.value));
                      $storage.setString(
                          StorageKeys.locale.key, selectedLocale.value);
                    },
                    children:
                        List<Widget>.generate(languages.length, (int index) {
                      return Center(child: Text(languages[index].languageName));
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
