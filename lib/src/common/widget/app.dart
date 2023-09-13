import 'package:flutter/material.dart';
import 'package:note_app/src/features/welcome_page/widget/welcome_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note App",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Ranade"
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const WelcomePage(),
    );
  }
}
