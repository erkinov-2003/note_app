import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';
import '../widget/change_password.dart';

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

  void openChangePasswordPage(
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChangePassword(),
        ),
      );
    }
  }

  String? validateEmail(String value, BuildContext context) {
    bool isSignedIn = allUsers.any((element) => element.email == value);
    if (!isSignedIn) {
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

