import 'package:flutter/material.dart';
import '../../../common/models/user_model.dart';
import '../../auth/widgets/registr_page_controller.dart';
import '../../home_screen/home_page.dart';
import 'language_changer_page.dart';
import 'theme_changer_page.dart';

class SplashScreen extends StatefulWidget {
  final List<User> users;

  const SplashScreen({super.key, required this.users});

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
    return widget.users.isNotEmpty
        ? const HomePage()
        : Scaffold(
            body: SizedBox.expand(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
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
                              builder: (context) => widget.users.isNotEmpty
                                  ? const HomePage()
                                  : const RegistrationPageController(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
