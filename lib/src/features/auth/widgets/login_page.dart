import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../controller/main_controller.dart';
import 'text_fields.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validatePassword = ProviderRegistration.of(context).validatePassword;
    final validateEmail = ProviderRegistration.of(context).validateEmail;
    final forgotPassword = ProviderRegistration.of(context).forgotPassword;
    final checkLogin = ProviderRegistration.of(context).checkLogin;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
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
          const SizedBox(height: 30),
          Center(
            child: FilledButton(
              style: FilledButton.styleFrom(
                maximumSize: const Size(400, 60),
                minimumSize: const Size(400, 60),
                backgroundColor: AppColors.airColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () => checkLogin(
                context,
                formKey,
                emailController,
                passwordController,
              ),
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
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () => forgotPassword(context),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
