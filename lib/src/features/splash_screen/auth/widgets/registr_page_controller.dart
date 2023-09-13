import 'package:flutter/material.dart';
import 'package:note_app/src/features/splash_screen/auth/controller/main_controller.dart';

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
  @override
  Widget build(BuildContext context) {
    final isRegistration = Provider.of(context).isRegistration;
    final onTap = Provider.of(context).onTap;
    final pageController = Provider.of(context).pageController;

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
                        PageWidget(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
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
