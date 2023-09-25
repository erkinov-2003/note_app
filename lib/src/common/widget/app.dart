
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../features/splash_screen/widget/splash_screen.dart';
import '../localization/generated/l10n.dart';
import '../models/user_model.dart';

class App extends StatelessWidget {
  final List<User> users;

  const App({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note App",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Ranade",
      ),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GeneratedLocalization.delegate,
      ],
      supportedLocales: GeneratedLocalization.delegate.supportedLocales,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: SplashScreen(users: users),
    );
  }
}
