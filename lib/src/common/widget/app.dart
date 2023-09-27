import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../features/splash_screen/widget/splash_screen.dart';
import '../localization/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../providers/lang_provider.dart';
import '../providers/photo_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/storage.dart';

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
            home: const SplashScreen(),
            locale: langProvider.getLocale(),
          );
        },
      ),
    );
  }
}
