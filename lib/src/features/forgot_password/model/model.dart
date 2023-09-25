import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';
import '../widget/chenge_password.dart';
import '../widget/forgot.dart';

class Model with ChangeNotifier {
  String email;
  String password;
  List<User> allUsers;

  Model({
    required this.email,
    required this.password,
    required this.allUsers,
  });

  void update(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void getAllUsers() async {
    String json = await ($secureStorage.read(key: StorageKeys.users.key)) ?? "";
    allUsers =
        List.from(jsonDecode(json)).map((e) => User.fromJson(e)).toList();
    notifyListeners();
  }

  void openChangePasswordPage(
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProviderForgot(
            model: Model(
              email: email,
              password: password,
              allUsers: allUsers,
            ),
            child: const ChangePassword(),
          ),
        ),
      );
    }
  }

  void openForgotPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProviderForgot(
          model: Model(
            email: email,
            password: password,
            allUsers: allUsers,
          ),
          child: const Forgot(),
        ),
      ),
    );
  }

  String? validateEmail(String value, BuildContext context) {
    bool isSighnedIn = allUsers.any((element) => element.email == value);
    if (!isSighnedIn) {
      return "Bunday foydalanuvchi yo'q";
    }
    update(value);
    return null;
  }

  void openHomePage(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      List<User> foundUsers =
          allUsers.where((element) => element.email == email).toList();
      int index = allUsers.indexOf(foundUsers.first);
      if (index != -1) {
        allUsers[index].loginPassword = password;
        await $secureStorage.write(
          key: StorageKeys.users.key,
          value: jsonEncode(
            allUsers.map((e) => e.toJson()).toList(),
          ),
        );
      }
      notifyListeners();
    }
    if (context.mounted) Navigator.pop(context);
  }
}

class ProviderForgot extends InheritedNotifier<Model> {
  const ProviderForgot({
    super.key,
    required super.child,
    required final Model model,
  }) : super(notifier: model);

  static Model of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen)?.notifier ?? _noInheritedWidgetError();

  static ProviderForgot? maybeOf(BuildContext context, {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<ProviderForgot>()
          : context.getElementForInheritedWidgetOfExactType<ProviderForgot>()?.widget
              as ProviderForgot?;

  static Never _noInheritedWidgetError() => throw ArgumentError(
      "No fount Inherited of type Provider", "out_of_scope");
}
