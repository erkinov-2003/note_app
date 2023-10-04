import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:note_app/src/common/models/controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dependencies.dart';
import '../utils/logger.dart';
import '../utils/storage.dart';

Future<Dependencies>? _initializeApp;
Future<Dependencies> $initializeApp({
  void Function(int percent, String message)? onProgress,
  FutureOr<void> Function(Dependencies dependencies)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) =>
    _initializeApp ??= Future<Dependencies>(
      () async {
        try {
          final dependencies = MutableDependencies();

          int totalSteps = _initializationSteps.length;
          int currentStep = 0;

          for (final step in _initializationSteps) {
            currentStep++;

            final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
            onProgress?.call(percent, step.$1);

            await step.$2(dependencies);
          }

          final immutableDependencies = dependencies.freeze();

          await onSuccess?.call(immutableDependencies);
          return immutableDependencies;
        } catch (error, stackTrace) {
          onError?.call(error, stackTrace);
          shout(error, stackTrace);
          rethrow;
        } finally {
          _initializeApp = null;
        }
      },
    );

final List<(String, FutureOr<void> Function(MutableDependencies dependencies))>
    _initializationSteps = [
  (
    'Initial app data',
    (_) async {
      await Future.delayed(const Duration(seconds: 1));
    },
  ),
  (
    'Initializing databases',
    (dependencies) async {
      $storage = await SharedPreferences.getInstance();
      $secureStorage = const FlutterSecureStorage();
      $users = Users();
    },
  ),
  (
    'Initializing Notes',
    (dependencies) async {
      // $storage.clear();

      await $users.getAllUser();
      $users.isLogged = $storage.getBool("isLogged") ?? false;

      if($users.isLogged){
        await $users.getOneUser();
        await $users.currentUser.notes!.setAllNotes();
       }

      }
  ),
  (
    'Custom Delay 1',
    (_) async {
      await Future.delayed(const Duration(seconds: 1));
    },
  ),
  (
    'App Initialized',
    (_) async {
      await Future.delayed(const Duration(milliseconds: 300));
    },
  ),
];
