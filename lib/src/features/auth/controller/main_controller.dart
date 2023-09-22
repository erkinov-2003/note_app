import 'dart:convert';

import 'package:flutter/material.dart';

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

  String? validatePassword(String? value) {
    if (value != null && !RegExp(r".{8,}").hasMatch(value)) {
      return "Password is too short, it must be at least 8 characters";
    }
    if (value != null && value.contains(" ")) {
      return "Password shouldn't have space";
    }
    if (value != null && !RegExp(r"\d").hasMatch(value)) {
      return "Password must have at least one number";
    }
    if (value != null && !RegExp(r"[a-z]").hasMatch(value)) {
      return "Password must have at least one letter";
    }
    if (value != null && !RegExp(r"[A-Z]").hasMatch(value)) {
      return "Password must have at least one Capital letter";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value != null &&
        !RegExp(r"^[a-zA-Z][a-zA-Z0-9]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$")
            .hasMatch(value)) {
      return "Invalid email address!";
    }
    return null;
  }

  String? validatePasswordR(String? value) {
    if (value != null && !RegExp(r".{8,}").hasMatch(value)) {
      return "Password is too short, it must be at least 8 characters";
    }
    if (value != null && value.contains(" ")) {
      return "Password shouldn't have space";
    }
    if (value != null && !RegExp(r"\d").hasMatch(value)) {
      return "Password must have at least one number";
    }
    if (value != null && !RegExp(r"[a-z]").hasMatch(value)) {
      return "Password must have at least one letter";
    }
    if (value != null && !RegExp(r"[A-Z]").hasMatch(value)) {
      return "Password must have at least one Capital letter";
    }
    return null;
  }

  String? validateEmailR(String? value) {
    if (users.any((e) => e.email == value)) {
      return "You are already Registered";
    }
    if (value != null &&
        !RegExp(r"^[a-zA-Z][a-zA-Z0-9]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$")
            .hasMatch(value)) {
      return "Invalid email address!";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value != null && value.length <= 3) {
      return "Invalid name!";
    }

    return null;
  }

  void getAllUsers() async {
    String json = await ($secureStorage.read(key: StorageKeys.users.key)) ?? "";
    users = List.from(jsonDecode(json)).map((e) => User.fromJson(e)).toList();
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
      bool isFounded = false;
      for (int i = 0; i < users.length; i++) {
        if (users[i].email == emailController.text.trim()) {
          user = users[i];
          isFounded = true;
        }
      }
      if (!isFounded) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(
              content: Text("You don't have Account"),
            ),
          );
      } else {
        if (user.loginPassword == passwordController.text.trim()) {
          await $secureStorage.write(
            key: StorageKeys.oneUser.key,
            value: jsonEncode(
              user.toJson(),
            ),
          );
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text("Wrong password"),
              ),
            );
        }
      }
    }
  }

  void checkRegistration(
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      User userOne = User(
        name: nameController.text,
        email: emailController.text,
        loginPassword: passwordController.text,
      );
      users.add(userOne);
      $secureStorage.write(
        key: StorageKeys.users.key,
        value: jsonEncode(
          users.map((e) => e.toJson()).toList(),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
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
