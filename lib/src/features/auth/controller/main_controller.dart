import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common/localization/generated/l10n.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';
import '../../forgot_password/widget/forgot.dart';
import '../../home_screen/home_page.dart';

class MainController with ChangeNotifier {
  User user = User();
  List<User> users = [];
  late PageController pageController;
  late TextEditingController textEditingController;
  int pageNumber = 1;
  bool isRegistration = true;

  MainController({
    required this.pageController,
  });

  final localization = GeneratedLocalization();

  String? validatePassword(String? value) {
    if (value != null && !RegExp(r".{8,}").hasMatch(value)) {
      return localization.passwordLength;
    }
    if (value != null && value.contains(" ")) {
      return localization.passwordSpace;
    }
    if (value != null && !RegExp(r"\d").hasMatch(value)) {
      return localization.passwordNumber;
    }
    if (value != null && !RegExp(r"[a-z]").hasMatch(value)) {
      return localization.passwordLetter;
    }
    if (value != null && !RegExp(r"[A-Z]").hasMatch(value)) {
      return localization.passwordCapitalLetter;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value != null &&
        !RegExp(r"^[a-zA-Z][a-zA-Z0-9]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$")
            .hasMatch(value)) {
      return localization.invalidEmail;
    }
    return null;
  }

  String? validatePasswordR(String? value) {
    if (value != null && !RegExp(r".{8,}").hasMatch(value)) {
      return localization.passwordLength;
    }
    if (value != null && value.contains(" ")) {
      return localization.passwordSpace;
    }
    if (value != null && !RegExp(r"\d").hasMatch(value)) {
      return localization.passwordNumber;
    }
    if (value != null && !RegExp(r"[a-z]").hasMatch(value)) {
      return localization.passwordLetter;
    }
    if (value != null && !RegExp(r"[A-Z]").hasMatch(value)) {
      return localization.passwordCapitalLetter;
    }
    return null;
  }

  String? validateEmailR(String? value) {
    if (users.any((e) => e.email == value)) {
      return localization.alreadyRegister;
    }
    if (value != null &&
        !RegExp(r"^[a-zA-Z][a-zA-Z0-9]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$")
            .hasMatch(value)) {
      return localization.invalidEmail;
    }
    return null;
  }

  String? validateName(String? value) {
    if (value != null && value.length <= 3) {
      return localization.invalidName;
    }

    return null;
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
      notifyListeners();
    } else if (!isRegistration) {
      pageNumber = 1;
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = true;
      notifyListeners();
    }
  }

  void forgotPassword(context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotWithModel(),
        ),
      );

  void checkLogin(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    if (formKey.currentState!.validate()) {
      users = $users.users;
      print(users);
      bool isFounded = false;
      for (int i = 0; i < users.length; i++) {
        if (users[i].email == emailController.text.trim()) {
          user = users[i];
          isFounded = true;
        }
      }
      if (!isFounded && context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
             SnackBar(
              content: Text(localization.doNotHave),
            ),
          );
      } else {
        if (user.loginPassword == passwordController.text.trim()) {
          await $secureStorage.write(
            key: StorageKeys.oneUser.key,
            value: user.toJson(),
          );
          await $users.getOneUser();
          await $users.currentUser.notes?.setAllNotes();
          $storage.setBool("isLogged", true);
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            );
          }
        } else {
         if(context.mounted) {
           ScaffoldMessenger.of(context)
             ..clearSnackBars()
             ..showSnackBar(
                SnackBar(
                 content: Text(localization.wrongPassword),
               ),
             );
         }
        }
      }
    }
  }

  Future<void> checkRegistration(
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      User userOne = User(
        name: nameController.text,
        email: emailController.text,
        loginPassword: passwordController.text,
      );
      await $secureStorage.write(
          key: StorageKeys.oneUser.key, value: jsonEncode(userOne.toJson()));
      users.add(userOne);
      $secureStorage.write(
        key: StorageKeys.users.key,
        value: jsonEncode(
          users.map((e) => e.toJson()).toList(),
        ),
      );
      await $storage.setBool("isLogged", true);
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

class ProviderRegistration extends InheritedNotifier<MainController> {
  const ProviderRegistration({
    required super.child,
    required final MainController controller,
    super.key,
  }) : super(notifier: controller);

  static MainController of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen)?.notifier ?? _noInheritedWidgetError();

  static ProviderRegistration? maybeOf(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<ProviderRegistration>()
          : context
              .getElementForInheritedWidgetOfExactType<ProviderRegistration>()
              ?.widget as ProviderRegistration?;

  static Never _noInheritedWidgetError() => throw ArgumentError(
        'Not found InheritedWidget of type Provider',
        'out_of_scope',
      );
}
