import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_app/src/features/home_screen/home_page.dart';
import '../../features/splash_screen/widget/splash_screen.dart';
import '../localization/generated/l10n.dart';
import 'package:note_app/src/common/providers/lang_provider.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:provider/provider.dart';

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
      ],
      child: Consumer<LangProvider>(
        builder: (context, value, child) {
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
            home: $notes.isLogged == "true"
                ? const HomePage()
                : const SplashScreen(),
            locale: value.getLocale(),
          );
        },
      ),
    );
  }
}
