import 'package:flutter/material.dart';

import '../../features/splash_screen/auth/widgets/registr_page_controller.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NoteAPP",
      theme: ThemeData(useMaterial3: true),
      home: const RegistrationPageController(),
    );
  }
}
