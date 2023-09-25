import 'package:flutter/cupertino.dart';
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
  List<LanguageModel> languages = const [
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

  LanguageModel selectedFruit = const LanguageModel(
    languageName: "Uzbek",
    icon: AppIcons.icUzb,
    value: "uz",
  );

  String value = "en";

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
              const Image(image: AssetImage(AppImages.languageBgImage)),
              SizedBox(
                height: 120,
                child: CupertinoPicker(
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
                    initialItem: 1
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      selectedFruit = languages[selectedItem];
                    });
                  },
                  children: List<Widget>.generate(languages.length, (int index) {
                    return Center(child: Text(languages[index].languageName));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
