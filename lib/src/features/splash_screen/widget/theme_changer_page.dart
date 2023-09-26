import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/localization/generated/l10n.dart';
import '../../../common/providers/theme_provider.dart';

class ThemeChangerPage extends StatefulWidget {
  const ThemeChangerPage({super.key});

  @override
  State<ThemeChangerPage> createState() => _ThemeChangerPageState();
}

class _ThemeChangerPageState extends State<ThemeChangerPage> {
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  GeneratedLocalization.of(context).themeApp,
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Image(
                    image: AssetImage(AppImages.themeBgImage),
                  ),
                ),
              ),
              Consumer<ThemeProvider>(
                builder: (context, value, child) => SwitchListTile.adaptive(
                  activeColor: Colors.black,
                  activeTrackColor: Colors.white,
                  value: value.themeMode == ThemeMode.light,
                  onChanged: value.changeTheme,
                  title: Text(
                    GeneratedLocalization.of(context).theme,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
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
