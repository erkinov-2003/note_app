import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/src/common/initialize/inherited_dependencies.dart';
import '/src/common/initialize/initialize.dart';
import '/src/common/widget/splash_screen.dart';

import 'src/common/models/user_model.dart';
import 'src/common/utils/storage.dart';
import 'src/common/widget/app.dart';
import 'src/common/widget/error_app.dart';
List<User> users = [];

void main() {
  final progress = ValueNotifier<
      ({
        int percent,
        String message,
      })>((percent: 0, message: ''));
  runApp(SplashScreen(progress: progress));

  $initializeApp(
    onProgress: (percent, message) {
      getAllUsers();
      progress.value = (
      percent: percent,
      message: message,
    );
    },
    onSuccess: (dependencies) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      runApp(
        InheritedDependencies(
          dependencies: dependencies,
          child: const App(),
        ),
      );
    },
    onError: (error, stackTrace) => runApp(
      ErrorApp(message: '$error'),
    ),
  ).ignore();
}

Future<void> getAllUsers() async {
  String json = await ($secureStorage.read(key: StorageKeys.users.key)) ?? "";
  users = List.from(jsonDecode(json)).map((e) => User.fromJson(e)).toList();
}
