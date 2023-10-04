import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/translate.dart';
import 'package:note_app/src/features/auth/validator/text_field_validator.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../controller/main_controller.dart';
import 'text_fields.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

 @override
  void didChangeDependencies() {
    context.read<MainController>().emailController = TextEditingController();
    context.read<MainController>().passwordController = TextEditingController();
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
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
                  validator: (value) => TextFieldValidator.validateEmail(context, value),
                  controller: context.read<MainController>().emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  exampleText: "you@example.com",
                  infoText: "Email address",
                ),
                TextFields(
                  controller: context.read<MainController>().passwordController,
                  validator: (value) => TextFieldValidator.validatePassword(context, value),
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
              onPressed: () => context.read<MainController>().checkLogin(
                context,
                formKey,
              ),
              child: Center(
                child: Translate(
                  builder: (context,localization, _) {
                    return Text(
                      localization.signIn,
                      style:  const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Center(
            child: GestureDetector(
              onTap: () => context.read<MainController>().forgotPassword(context),
              child: Translate(
                builder: (context, localization, _) {
                  return Text(
                    localization.forgotPassword,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.airColor,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
