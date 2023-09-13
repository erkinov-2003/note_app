import 'package:flutter/material.dart';

import '../../features/splash_screen/auth/controller/main_controller.dart';
import '../../features/splash_screen/auth/widgets/registr_page_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NoteAPP",
      theme: ThemeData(useMaterial3: true),
      home: const AppNote(),
    );
  }
}

class AppNote extends StatefulWidget {
  const AppNote({super.key});

  @override
  State<AppNote> createState() => _AppNoteState();
}

class _AppNoteState extends State<AppNote> {
  late MainController controller;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    controller = MainController(
      pageController: pageController,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      controller: controller,
      child: const RegistrationPageController(),
    );
  }
}
