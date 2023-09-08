import 'package:flutter/material.dart';

import '../model/text_feild.dart';
import 'chenge_password.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  late String email;

  String? validateEmail(String? value) {
    if (value == null) {
      return "Emailda kamida bitta harf bo'lishi kerak";
    }
    if (!RegExp(r'[A-z]+[@]').hasMatch(value)) {
      return "Email harflardan boshlanishi va @ belgisi bo'lishi shart";
    }
    if (!RegExp(r'[A-z]+[@][A-z]').hasMatch(value)) {
      return "Emailda @ belgidan keyin kamida bitta harf bo'lishi kerak";
    }
    if (!value.contains(".com")) {
      return "Emailda '.com' bo'lishi shart";
    }
    email = value;
    return null;
  }

  void openKey(bool a) {
    a = !a;
    setState(() {});
    print(a);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Forgot(),
            ),
          ),
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
                  padding: EdgeInsets.only(top: size.height * 0.005),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.height * 0.041,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.21),
                  child: const Text(
                    "Enter Email address",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF575758),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.012),
                        child: TextEdit(
                          value: "you@example.com",
                          validateEmail: validateEmail,
                          isPassword: false,
                          isRead: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.37),
                        child: ElevatedButton(
                          style: ButtonStyle(
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePassword(value: email),
                                  ));
                            }
                          },
                          child: Text(
                            "Send code",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.019,
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
