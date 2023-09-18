import 'package:flutter/material.dart';

class ErrorApp extends StatelessWidget {
  const ErrorApp({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(
                'Something went wrong. Error : $message',
                textScaleFactor: 2,
              ),
            ),
          ),
        ),
      );
}
