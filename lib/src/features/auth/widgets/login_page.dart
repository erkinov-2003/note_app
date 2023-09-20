import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/models/user_model.dart';
import '../../../common/utils/storage.dart';
import '../../forgot_password/widget/forgot.dart';
import '../../home_screen/widgets/home_page.dart';
import 'text_fields.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  User user = User();
  List<User> users = [];
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getAllUsers();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void getAllUsers() async {
    String json = await ($secureStorage.read(key: StorageKeys.users.key)) ?? "";
    users = List.from(jsonDecode(json)).map((e) => User.fromJson(e)).toList();
  }

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 230,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  TextFields(
                    validator: validateEmail,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    exampleText: "you@example.com",
                    infoText: "Email address",
                  ),
                  TextFields(
                    controller: passwordController,
                    validator: validatePassword,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.visiblePassword,
                    exampleText: "Your password",
                    infoText: "Password",
                    isObscure: true,
                  ),
                ],
              ),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  bool isFounded = false;
                  for (int i = 0; i < users.length; i++) {
                    if (users[i].email == emailController.text.trim()) {
                      user = users[i];
                      isFounded = true;
                    }
                  }
                  if (!isFounded) {
                    ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
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
                      ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
                        const SnackBar(
                          content: Text("Wrong password"),
                        ),
                      );
                    }
                  }
                }
              },
              child: const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotWithModel(),
                ),
              ),
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.airColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
