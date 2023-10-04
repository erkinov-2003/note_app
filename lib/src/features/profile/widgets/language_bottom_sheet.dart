import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/localization/generated/l10n.dart';
import '../../../common/providers/lang_provider.dart';
import '../../../common/utils/storage.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization=GeneratedLocalization();
    List<String> list = [
      "English",
      "Русский",
      "O'zbek",
    ];
    List<String> imagesPath = [
      AppIcons.ukFlag,
      AppIcons.ruFlag,
      AppIcons.uzFlag,
    ];
    return SizedBox(
      height: size.height * 0.372,
      child: BottomSheet(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          )
        ),
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
                    style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),
                  ),
                  const SizedBox(width: 20),
                  const Image(
                    image: AssetImage(AppIcons.globe),
                    color: AppColors.white,
                    height: 20,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel, color: Colors.white,),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<LangProvider>(builder:  (context, value, child) => ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                String locale = switch(index){
                  0=>"en",
                  1=>"ru",
                  2=>"uz",
                  _=>"en",
                };
                return ListTile(
                    title: SizedBox(
                      height: 45,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: locale == value.current.languageCode
                              ? AppColors.selectedLanguageColor
                              : AppColors.unSelectedLanguageColor,
                        ),
                        onPressed: () async {
                         value.changeLocale(Locale(locale));
                          await $storage.setString(StorageKeys.locale.key, locale );
                          if(context.mounted) Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              list[index].toString(),
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
            )),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
