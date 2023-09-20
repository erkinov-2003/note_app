import 'package:flutter/material.dart';
import '../../forgot_password/widget/forgot.dart';
import 'text_fields.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {},
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
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotWithModel(),
                ),
              ),
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF36BFFA),
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
