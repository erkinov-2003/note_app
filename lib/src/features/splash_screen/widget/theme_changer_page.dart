import 'package:flutter/material.dart';

import '../../../common/constants/app_images.dart';

class ThemeChangerPage extends StatefulWidget {
  const ThemeChangerPage({super.key});

  @override
  State<ThemeChangerPage> createState() => _ThemeChangerPageState();
}

class _ThemeChangerPageState extends State<ThemeChangerPage> {
  bool isDark = true;

  void changeTheme(bool value) {
    setState(() {
      isDark = value;
    });
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
                  "Theme APP",
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
                    image: AssetImage(AppImages.themeBgImage),
                  ),
                ),
              ),
              SwitchListTile.adaptive(
                activeColor: Colors.black,
                activeTrackColor: Colors.white,
                value: isDark,
                onChanged: changeTheme,
                title: const Text(
                  "Theme",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
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
            ],
          ),
        ),
      ),
    );
  }
}
