import 'package:flutter/material.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final localization=GeneratedLocalization();
    List<String> list = [
      "English",
      "Russia",
      "Uzbek",
    ];
    List<String> imagesPath = [
      AppIcons.ukFlag,
      AppIcons.ruFlag,
      AppIcons.uzFlag,
    ];
    int index = $storage.getInt(StorageKeys.locale.key) ?? 0;
    ValueNotifier<int> selected = ValueNotifier(index);
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 20),
            child: Row(
              children: [
                 Text(
                  localization.language,
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 20),
                const Image(
                  image: AssetImage(AppIcons.globe),
                  color: AppColors.black,
                  height: 20,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder(
              valueListenable: selected,
              builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: SizedBox(
                      height: 45,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: index == value
                              ? AppColors.selectedLanguageColor
                              : AppColors.unSelectedLanguageColor,
                        ),
                        onPressed: () async {
                          selected.value = index;
                          await $storage.setInt(StorageKeys.locale.key, index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              list[index],
                              style: const TextStyle(color: AppColors.white),
                            ),
                            Image(
                              height: 40,
                              width: 40,
                              image: AssetImage(imagesPath[index]),
                            ),
                          ],
                        ),
                      ),
                    ));
                  },
                );
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
