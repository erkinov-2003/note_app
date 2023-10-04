import 'package:flutter/material.dart';
import 'package:note_app/src/common/models/controller/user_controller.dart';
import 'package:note_app/src/common/utils/app_snack_bar.dart';
import 'package:note_app/src/common/utils/functions.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/features/forgot_password/widget/forgot.dart';
import 'package:note_app/src/features/home_screen/home_page.dart';

class MainController with ChangeNotifier {
  late PageController pageController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  int pageNumber = 1;
  bool isRegistration = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void onTap2() {
    if (isRegistration) {
      pageNumber = 2;
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = false;
      notifyListeners();
    } else if (!isRegistration) {
      pageNumber = 1;
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = true;
      notifyListeners();
    }
  }

  void checkLogin(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      Status status = await $users.checkLogin(
          email: emailController.text, password: passwordController.text);
      if (status == Status.notLogged && context.mounted) {
        AppSnackBar.showSnackBar(
          context: context,
          message: translate(context).doNotHave,
        );
      } else if (status == Status.wrongPassword && context.mounted) {
        AppSnackBar.showSnackBar(
            context: context, message: translate(context).wrongPassword);
      } else if (status == Status.logged && context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    }
  }

  void forgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Forgot(initialText: ""),
      ),
    );
  }

  Future<void> checkRegistration(
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      await $users.checkRegistration(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    }
  }
}
