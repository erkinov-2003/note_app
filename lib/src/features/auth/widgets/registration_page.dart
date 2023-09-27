import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/localization/generated/l10n.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';
import '../../home_screen/home_page.dart';
import 'text_fields.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final localization = GeneratedLocalization();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

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

  String? validateName(String? value) {
    if (value != null && value.length <= 3) {
      return localization.invalidName;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: size.height * 0.46,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  TextFields(
                    controller: nameController,
                    validator: validateName,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    exampleText: localization.yourFullName,
                    infoText: localization.fullName,
                  ),
                  TextFields(
                    validator: validateEmail,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    exampleText: "you@example.com",
                    infoText: localization.emailAddress,
                  ),
                  TextFields(
                    controller: passwordController,
                    validator: validatePassword,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.visiblePassword,
                    exampleText: localization.yourPassword,
                    infoText: localization.password,
                    isObscure: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  maximumSize: const Size(400, 60),
                  minimumSize: const Size(400, 60),
                  backgroundColor: AppColors.airColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    User userOne = User(
                      name: nameController.text,
                      email: emailController.text,
                      loginPassword: passwordController.text,
                    );

                    await $secureStorage.write(
                        key: StorageKeys.oneUser.key,
                        value: jsonEncode(userOne.toJson()));
                    $storage.setBool("isLogged", true);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Center(
                  child: Text(
                    localization.signIn,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
