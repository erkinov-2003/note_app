import 'package:flutter/material.dart';
import '../../../common/localization/generated/l10n.dart';
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
  final localization = GeneratedLocalization();

  @override
  Widget build(BuildContext context) {
    final isRegistration =
        ProviderRegistration.of(context, listen: true).isRegistration;
    final onTap = ProviderRegistration.of(context).onTap;
    final pageController = ProviderRegistration.of(context).pageController;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.17,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isRegistration
                              ? Text(
                                  localization.signUpTitle,
                                  style:  TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                  ),
                                )
                              : Text(
                                  localization.signInTitle,
                                  style:  TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                  ),
                                ),
                          const PageWidget(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.5,
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
                  SizedBox(
                    height: size.height * 0.2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.01),
                      child: Column(
                        children: [
                          const Spacer(),
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
      ),
    );
  }
}
