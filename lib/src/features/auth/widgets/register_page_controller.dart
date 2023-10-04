
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
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                    width: size.width,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: isRegistration
                          ? Text(
                              localization.signUpTitle,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            )
                          : Text(
                              localization.signInTitle,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: const PageWidget(),
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
                  SizedBox(height:size.height > 800 ?  size.height * 0.2 : size.height *0.05),
                  SizedBox(
                    // height: size.height * 0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.005),
                      child: Center(
                        child: SignInWith(),
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
