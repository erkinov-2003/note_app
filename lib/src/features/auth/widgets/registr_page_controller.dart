import 'package:flutter/material.dart';
import 'package:note_app/src/common/constants/app_colors.dart';
import '../controller/main_controller.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'page_widget.dart';
import 'signing_with.dart';

class RegistrationPageController extends StatefulWidget {
  const RegistrationPageController({super.key});

  @override
  State<RegistrationPageController> createState() =>
      _RegistrationPageControllerState();
}

class _RegistrationPageControllerState
    extends State<RegistrationPageController> {
  late MainController controller;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    controller = MainController(
      pageController: pageController,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderRegistration(
      controller: controller,
      child: const View(),
    );
  }
}

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    final isRegistration = ProviderRegistration.of(context, listen: true).isRegistration;
    final onTap = ProviderRegistration.of(context).onTap;
    final pageController = ProviderRegistration.of(context).pageController;

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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        isRegistration
                            ? const Text(
                                "Your NOTE in the here...",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              )
                            : const Text(
                                "Welcome to back\nYour NOTE...",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              ),
                        const SizedBox(height: 5),
                        const PageWidget(),
                        // const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
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
                  flex: 2,
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
