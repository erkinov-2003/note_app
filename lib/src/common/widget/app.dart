import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_app/src/features/create_note/create_note.dart';
import 'package:note_app/src/features/home_screen/home_page.dart';
import '../../features/splash_screen/widget/splash_screen.dart';
import '../localization/generated/l10n.dart';
import '../models/user_model.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/features/profile/profile_page.dart';
import 'package:note_app/src/features/splash_screen/widget/splash_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final List<User> users;

  const App({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: $notes,
      child: MaterialApp(
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
        home: const CreateNote(),
      ),
    );
  }
}
