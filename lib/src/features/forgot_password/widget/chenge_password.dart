import 'package:flutter/material.dart';
import '../../../common/localization/generated/l10n.dart';
import '../model/model.dart';
import '../model/text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String password = "";

  String? validatePasswordOne(String? value) {
    if (value!.length < 8) {
      return "Parol kamida 8 ta belgi bo'lishi shart";
    }
    password = value;
    return null;
  }

  String? validatePasswordTwo(String? value) {
    if (value != password) {
      return "Parolni qayta tekshirib ko'ring";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final localization = GeneratedLocalization();
    final model = ProviderForgot.of(context);
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: ()=> model.openForgotPage(context),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.005),
                  child: Text(
                    localization.setPassword,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.height * 0.041,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.059),
                        child: const Text(
                          "Your email address",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF575758),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: model.email,
                          isPassword: false,
                          isRead: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: const Text(
                          "Enter new password",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF575758),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: "you@example.com",
                          validateEmail: validatePasswordOne,
                          isPassword: true,
                          isRead: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: const Text(
                          "Enter again",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF575758),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: "you@example.com",
                          validateEmail: validatePasswordTwo,
                          isPassword: true,
                          isRead: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            const MaterialStatePropertyAll<Color>(
                              Color(0xFF36BFFA),
                            ),
                            fixedSize: MaterialStatePropertyAll<Size>(
                              Size(
                                size.width,
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
                              model.openHomePage(context, formKey),
                          child: Text(
                            "Enter",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.019,
                              color: Colors.white,
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
