import 'package:flutter/material.dart';

import '../../features/splash_screen/auth/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoteAPP",
      theme: ThemeData(useMaterial3: true),
      home: const LogIn(),
    );
  }
}
