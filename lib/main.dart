import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/src/common/initialize/inherited_dependencies.dart';
import '/src/common/initialize/initialize.dart';
import '/src/common/widget/splash_screen.dart';
import 'src/common/widget/app.dart';
import 'src/common/widget/error_app.dart';

void main() {
  final progress = ValueNotifier<
      ({
        int percent,
        String message,
      })>((percent: 0, message: ''));
  runApp(SplashScreen(progress: progress));

  $initializeApp(
    onProgress: (percent, message) {
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

