import 'package:flutter/material.dart';

import '../../features/forgot_password/widget/forgot.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Forgot(),
    );
  }
}
