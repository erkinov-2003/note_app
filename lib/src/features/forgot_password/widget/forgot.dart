import 'package:flutter/material.dart';
import 'package:note_app/src/features/forgot_password/model/model.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/localization/generated/l10n.dart';
import '../model/text_field.dart';

class ForgotWithModel extends StatefulWidget {

  const ForgotWithModel({Key? key}) : super(key: key);

  @override
  State<ForgotWithModel> createState() => _ForgotWithModelState();
}

class _ForgotWithModelState extends State<ForgotWithModel> {
  late Model model;

  @override
  void initState() {
    super.initState();
    model = Model(
      email: "",
      password: "",
      allUsers: [],
    );
    model.getAllUsers();
  }

  @override
  void dispose() {
    super.dispose();
    model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderForgot(
      model: model,
      child: const Forgot(),
    );
  }
}

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  void openKey(bool a) {
    a = !a;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localization = GeneratedLocalization();
    final email = ProviderForgot.of(context);
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: AppColors.white,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
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
                      color: AppColors.white,
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
                              email.validateEmail(value!, context),
                          isPassword: false,
                          isRead: false,
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
                          onPressed: () =>
                              email.openChangePasswordPage(formKey, context),
                          child: Text(
                            "Send code",
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
