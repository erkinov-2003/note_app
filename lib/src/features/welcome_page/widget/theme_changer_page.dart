import 'package:flutter/material.dart';
import 'package:note_app/src/common/constants/app_images.dart';
import 'package:note_app/src/common/provider/welcome_page_provider.dart';

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
    final pageController = WelcomePageProvider.of(context).pageController;
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
                  "Theme APP",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Image(image: AssetImage(AppImages.themeBgImage)),
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
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
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
