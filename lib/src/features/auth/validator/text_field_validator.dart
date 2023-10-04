import 'package:flutter/cupertino.dart';
import 'package:note_app/src/common/utils/functions.dart';
import 'package:note_app/src/common/utils/storage.dart';

abstract class TextFieldValidator {
  static String? validatePassword(BuildContext context, String? value) {
    if (value != null && !RegExp(r".{8,}").hasMatch(value)) {
      return translate(context).passwordLength;
    }
    if (value != null && value.contains(" ")) {
      return translate(context).passwordSpace;
    }
    if (value != null && !RegExp(r"\d").hasMatch(value)) {
      return translate(context).passwordNumber;
    }
    if (value != null && !RegExp(r"[a-z]").hasMatch(value)) {
      return translate(context).passwordLetter;
    }
    if (value != null && !RegExp(r"[A-Z]").hasMatch(value)) {
      return translate(context).passwordCapitalLetter;
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value != null &&
        !RegExp(r"^[a-zA-Z][a-zA-Z0-9]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$")
            .hasMatch(value)) {
      return translate(context).invalidEmail;
    }
    return null;
  }

  static String? validateEmailForgot(String? value, BuildContext context) {
    bool isSignedIn = $users.users.any((element) => element.email == value);

    if (!isSignedIn) {
      return "Bunday foydalanuvchi yo'q";
    }
    return null;
  }

  static String? validateEmailR(BuildContext context, String? value) {
    if ($users.users.any((e) => e.email == value)) {
      return translate(context).alreadyRegister;
    }
    if (value != null &&
        !RegExp(r"^[a-zA-Z][a-zA-Z0-9]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$")
            .hasMatch(value)) {
      return translate(context).invalidEmail;
    }
    return null;
  }

  static String? validateName(BuildContext context, String? value) {
    if (value != null && value.length <= 3) {
      return translate(context).invalidName;
    }
    return null;
  }
}
