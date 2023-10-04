import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/common/utils/translate.dart';
import '../model/text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key? key,
    required this.initialText,
  }) : super(key: key);

  final String initialText;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String password = "";
  final formKey = GlobalKey<FormState>();

  String? validatePasswordOne(String? value) {
    if (value!.length < 8) {
      return "Password is too short, it must be at least 8 characters";
    }
    password = value;
    return null;
  }

  String? validatePasswordTwo(String? value) {
    if (value != password) {
      return "Please check the password again";
    }
    return null;
  }

  void openHomePage() {
    if(formKey.currentState?.validate() ?? false) {
      $users.updatePassword(
        email: widget.initialText,
        password: password,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: BackButton(
          onPressed: () {},
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.005),
                  child: Translate(builder: (context, localization, child) {
                    return Text(
                      localization.setPassword,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.041,
                        color: theme.primaryColor,
                      ),
                    );
                  }),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.059),
                        child:
                            Translate(builder: (context, localization, child) {
                          return Text(
                            localization.yourEmailAddress,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF575758),
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: widget.initialText,
                          isPassword: false,
                          isRead: true,
                          controller: TextEditingController(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child:
                            Translate(builder: (context, localization, child) {
                          return Text(
                            localization.enterNewPassword,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF575758),
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: "you@example.com",
                          validateEmail: validatePasswordOne,
                          isPassword: true,
                          isRead: false,
                          controller: TextEditingController(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child:
                            Translate(builder: (context, localization, child) {
                          return Text(
                            localization.enterAgain,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF575758),
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: "you@example.com",
                          validateEmail: validatePasswordTwo,
                          isPassword: true,
                          isRead: false,
                          controller: TextEditingController(),
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
                          onPressed: openHomePage,
                          child: Translate(
                              builder: (context, localization, child) {
                            return Text(
                              localization.enter,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.019,
                                color: Colors.white,
                              ),
                            );
                          }),
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
