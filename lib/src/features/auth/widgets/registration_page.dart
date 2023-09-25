import 'package:flutter/material.dart';
import '../../../common/constants/app_colors.dart';
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

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
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

  String? validateName(String? value) {
    if (value != null && value.length <= 3) {
      return "Invalid name!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: size.height*0.46,
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
                    exampleText: "Your Full Name",
                    infoText: "Full Name",
                  ),
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
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
