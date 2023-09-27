import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/translate.dart';
import 'package:provider/provider.dart';
import 'controller/main_controller.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'widgets/page_widget.dart';
import 'widgets/signing_with.dart';

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
      builder: (context, child) {
        return const View();
      },
    );
  }
}

class View extends StatefulWidget {
  const View({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Translate(builder: (context, localization, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Selector<MainController, bool>(builder: (context, isRegistration, child) {
                                  return Text(
                                    isRegistration
                                        ? localization.signInTitle
                                        : localization.signUpTitle,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  );
                                }, selector: (_, model) => model.isRegistration,),
                              ),
                            ),
                            const PageWidget(),
                          ],
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.6 - MediaQuery.of(context).padding.top,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      // onPageChanged: context.read<MainController>().onTap,
                      controller: context.read<MainController>().pageController,
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
                      child: const Column(
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
      ),
    );
  }
}

