import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/localization/generated/l10n.dart';
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

  final localization = GeneratedLocalization();

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
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
          SizedBox(height: size.height * 0.02),
          Center(
            child: FilledButton(
              style: FilledButton.styleFrom(
                maximumSize:  Size(size.width * 0.9, size.height * 0.07),
                minimumSize:  Size(size.width * 0.9, size.height * 0.07),
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
              child: Center(
                child: Text(
                  localization.signIn,
                  style:  const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Center(
            child: GestureDetector(
              onTap: () => forgotPassword(context),
              child: Text(
                localization.forgotPassword,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.airColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
