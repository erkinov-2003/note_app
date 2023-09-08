import 'package:flutter/material.dart';

import '../login_page.dart';
import '../registration_page.dart';
import 'page_widget.dart';
import 'signin_with.dart';

class RegistrationPageController extends StatefulWidget {
  const RegistrationPageController({Key? key}) : super(key: key);

  @override
  State<RegistrationPageController> createState() =>
      _RegistrationPageControllerState();
}

class _RegistrationPageControllerState
    extends State<RegistrationPageController> {
  late PageController pageController;
  int pageNumber = 1;

  bool isRegistration = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int pageNumber) {
    pageController.animateToPage(
      pageNumber,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void onTap2() {
    if (isRegistration) {
      pageNumber = 2;
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = false;
      setState(() {});
    } else if (!isRegistration) {
      pageNumber = 1;
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        isRegistration
                            ? const Text(
                                "Your NOTE in\nthe here...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 35,
                                ),
                              )
                            : const Text(
                                "Welcome to back\nYour NOTE...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 35,
                                ),
                              ),
                        const SizedBox(height: 10),
                        PageWidget(
                          onTap: onTap2,
                          isRegistration: isRegistration,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    onPageChanged: onTap,
                    controller: pageController,
                    children: const [
                      RegistrationPage(),
                      LogIn(),
                    ],
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Column(
                      children: [
                        Spacer(),
                        Center(
                          child: SignInWith(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
