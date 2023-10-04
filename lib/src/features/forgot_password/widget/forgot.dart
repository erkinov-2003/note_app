import 'package:flutter/material.dart';
import 'package:note_app/src/features/auth/validator/text_field_validator.dart';
import 'package:note_app/src/features/forgot_password/widget/change_password.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/localization/generated/l10n.dart';
import '../model/text_field.dart';

class Forgot extends StatefulWidget {
  const Forgot({
    super.key,
    required this.initialText,
  });

  final String initialText;

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = GeneratedLocalization();
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: BackButton(
          color: theme.primaryColor,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.09),
                  child: Text(
                    localization.forgotPassword,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.height * 0.041,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: Text(
                    localization.enterEmailAddress,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: "you@example.com",
                          validateEmail: (value) =>
                              TextFieldValidator.validateEmailForgot(
                                  value, context),
                          isPassword: false,
                          isRead: false,
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.45),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                              AppColors.airColor,
                            ),
                            fixedSize: MaterialStatePropertyAll<Size>(
                              Size(
                                size.width * 0.85,
                                size.height * 0.071,
                              ),
                            ),
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePassword(
                                    initialText: emailController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            localization.sendCode,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.019,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
