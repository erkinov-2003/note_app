import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';
import '../../home_screen/widgets/home_page.dart';
import '../widget/chenge_password.dart';
import '../widget/forgot.dart';

class Model with ChangeNotifier {
  String email;
  String password;

  Model({required this.email, required this.password});

  void update(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void openChangePasswordPage(
    GlobalKey<FormState> _formKey,
    BuildContext context,
  ) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Provider(
            child: ChangePassword(),
            model: Model(
              email: email,
              password: password,
            ),
          ),
        ),
      );
    }
  }

  void openForgotPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Provider(
          child: Forgot(),
          model: Model(
            email: email,
            password: password,
          ),
        ),
      ),
    );
  }

  void openHomePage(
    BuildContext context,
    GlobalKey<FormState> _formKey,
  ) {
    if (_formKey.currentState!.validate()) {
      List<String> users = $storage.getStringList("users") ?? [];
      List<User> allUsers = List<User>.from(
              users.map((e) => User.fromMap(jsonDecode(e))).toList())
          .toList();
      List<User> foundUsers =
          allUsers.where((element) => element.email == email).toList();
      int index = allUsers.indexOf(foundUsers.first);
      if (index != -1) {
        allUsers.removeAt(index);
        User newUser = foundUsers.first.copyWith(loginPassword: password);
        allUsers.insert(index, newUser);
        users = allUsers.map((e) => jsonEncode(e.toJson())).toList();
        $storage.setStringList("users", users);
        // print(users);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }
}

class Provider extends InheritedNotifier<Model> {
  const Provider({
    super.key,
    required super.child,
    required final Model model,
  }) : super(notifier: model);

  static Model of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen)?.notifier ?? _noInheritedWidgetError();

  static Provider? maybeOf(BuildContext context, {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<Provider>()
          : context.getElementForInheritedWidgetOfExactType<Provider>()?.widget
              as Provider?;

  // static Provider? maybeOf(BuildContext context, {bool listen=false})=> listen?context.dependOnInheritedWidgetOfExactType<Provider>()<Provider>():context.getElementForInheritedWidgetOfExactType<Provider>()?.widget as Provider?;

  static Never _noInheritedWidgetError() => throw ArgumentError(
      "No fount Inherited of type Provider", "out_of_scope");
}
