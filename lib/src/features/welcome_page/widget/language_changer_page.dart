import 'package:flutter/material.dart';

import '../../../common/constants/app_icons.dart';
import '../../../common/constants/app_images.dart';
import '../models/language_model.dart';

class LanguageChangerPage extends StatefulWidget {
  const LanguageChangerPage({super.key});

  @override
  State<LanguageChangerPage> createState() => _LanguageChangerPageState();
}

class _LanguageChangerPageState extends State<LanguageChangerPage> {
  List<LanguageModel> languages = [
    const LanguageModel(
      languageName: "English",
      icon: AppIcons.icEng,
      value: "en",
    ),
    const LanguageModel(
      languageName: "Russian",
      icon: AppIcons.icRus,
      value: "ru",
    ),
    const LanguageModel(
      languageName: "Uzbek",
      icon: AppIcons.icUzb,
      value: "uz",
    ),
  ];

  String value = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 33,
            vertical: 35,
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
              const Image(image: AssetImage(AppImages.languageBgImage)),
              Column(
                children: List.generate(
                  3,
                  (index) {
                    LanguageModel language = languages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        height: 50,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: language.value == value
                              ? const Color(0xFF36BFFA)
                              : const Color(0xFF575758),
                          title: Text(language.languageName),
                          onTap: () {
                            setState(() {
                              value = language.value;
                            });
                          },
                          titleTextStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                              image: AssetImage(language.icon),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF36BFFA),
                  maximumSize: const Size(double.infinity, 70),
                  minimumSize: const Size(double.infinity, 70),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
