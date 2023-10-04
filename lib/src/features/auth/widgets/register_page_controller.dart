
import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/translate.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainController(),
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
  void didChangeDependencies() {
    context.read<MainController>().pageController = PageController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Selector<MainController, bool>(
                      builder: (context, isRegistration, child) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04),
                          child: Translate(builder: (context, localization, _) {
                            return Text(
                              isRegistration
                                  ? localization.signUpTitle
                                  : localization.signInTitle,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isRegistration ? 28 : 24,
                              ),
                            );
                          }),
                        );
                      },
                      selector: (_, model) => model.isRegistration,
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
                      controller: context.read<MainController>().pageController,
                      children: const [
                        RegistrationPage(),
                        LogIn(),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: size.height > 800
                          ? size.height * 0.2
                          : size.height * 0.05),
                  SizedBox(
                    // height: size.height * 0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.005),
                      child: const Center(
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
