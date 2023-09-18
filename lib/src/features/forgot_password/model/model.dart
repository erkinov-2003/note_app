import 'package:flutter/material.dart';

import '../widget/chenge_password.dart';
import '../widget/forgot.dart';

class Model with ChangeNotifier {
  String email;

  Model({required this.email});

  void update(String value) {
    email = value;
    notifyListeners();
  }

  void openChangePasswordPage(
      GlobalKey<FormState> _formKey, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Provider(
            child: ChangePassword(),
            model: Model(email: email),
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
          model: Model(email: email),
        ),
      ),
    );
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
