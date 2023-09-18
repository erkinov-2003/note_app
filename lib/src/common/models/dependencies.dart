import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../initialize/inherited_dependencies.dart';

abstract interface class Dependencies {
  static Dependencies of(BuildContext context) => InheritedDependencies.of(context);

  abstract final SharedPreferences storage;
  abstract final FlutterSecureStorage secureStorage;
}

final class MutableDependencies implements Dependencies {
  @override
  late SharedPreferences storage;

  @override
  late FlutterSecureStorage secureStorage;

  Dependencies freeze() => ImmutableDependencies(
        storage: storage,
        secureStorage: secureStorage,
      );
}

final class ImmutableDependencies implements Dependencies {
  const ImmutableDependencies({
    required this.storage,
    required this.secureStorage,
  });

  @override
  final SharedPreferences storage;

  @override
  final FlutterSecureStorage secureStorage;
}
