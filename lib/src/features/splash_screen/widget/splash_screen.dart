import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/translate.dart';

import '../../../common/constants/app_colors.dart';
import '../../auth/register_page_controller.dart';
import 'language_changer_page.dart';
import 'theme_changer_page.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: const [
                        ThemeChangerPage(),
                        LanguageChangerPage(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 35,
                      right: 35,
                      bottom: 35,
                    ),
                    child: FilledButton(
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
                        if (pageController.page != null &&
                            pageController.page?.toInt() == 0) {
                          pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationPageController(),
                            ),
                          );
                        }
                      },
                      child: Translate(
                        builder: (context, localization, child) {
                          return Text(
                            localization.next,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
