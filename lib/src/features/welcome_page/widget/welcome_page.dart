import 'package:flutter/material.dart';
import 'package:note_app/src/common/provider/welcome_page_provider.dart';
import 'package:note_app/src/features/welcome_page/widget/language_changer_page.dart';
import 'package:note_app/src/features/welcome_page/widget/theme_changer_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            WelcomePageProvider(
              pageController,
              child: const ThemeChangerPage(),
            ),
            const LanguageChangerPage(),
          ],
        ),
      ),
    );
  }
}
