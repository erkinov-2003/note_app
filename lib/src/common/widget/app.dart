import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_app/src/common/providers/theme_provider.dart';
import 'package:note_app/src/features/home_screen/home_page.dart';
import '../../features/splash_screen/widget/splash_screen.dart';
import '../localization/generated/l10n.dart';
import 'package:note_app/src/common/providers/lang_provider.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:provider/provider.dart';

import '../providers/photo_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: $notes),
        ChangeNotifierProvider(
          create: (context) => LangProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhotoProvider(),
        ),
      ],
      child: Consumer2<LangProvider, ThemeProvider>(
        builder: (context, langProvider, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Note App",
            localizationsDelegates: const <LocalizationsDelegate<Object>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GeneratedLocalization.delegate,
            ],
            supportedLocales: GeneratedLocalization.delegate.supportedLocales,
            theme: ThemeProvider.lightTheme,
            darkTheme: ThemeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: $notes.isLogged == true
                ? const HomePage()
                : const SplashScreen(),
            locale: langProvider.getLocale(),
          );
        },
      ),
    );
  }
}
