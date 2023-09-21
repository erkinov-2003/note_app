import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';

import '../../features/home_screen/widgets/home_page.dart';


class App extends StatelessWidget {
  const App({super.key});

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
      home:  const HomePage(),
    );
  }
}
