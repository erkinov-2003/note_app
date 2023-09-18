import 'package:flutter/material.dart';

import 'text_fields.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 265,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFields(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  exampleText: "Your Full Name",
                  infoText: "Full Name",
                ),
                TextFields(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  exampleText: "you@example.com",
                  infoText: "Email address",
                ),
                TextFields(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.visiblePassword,
                  exampleText: "Your password",
                  infoText: "Password",
                  isObscure: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: FilledButton(
              style: FilledButton.styleFrom(
                maximumSize: const Size(400, 60),
                minimumSize: const Size(400, 60),
                backgroundColor: const Color(0xFF36BFFA),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
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
    );
  }
}
