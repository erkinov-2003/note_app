import 'package:flutter/cupertino.dart';
import 'package:note_app/src/common/initialize/inherited_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class Dependencies {
  static Dependencies of(BuildContext context) => InheritedDependencies.of(context);

  abstract final SharedPreferences storage;
}

final class MutableDependencies implements Dependencies {
  @override
  late SharedPreferences storage;

  Dependencies freeze() => ImmutableDependencies(
        storage: storage,
      );
}

final class ImmutableDependencies implements Dependencies {
  const ImmutableDependencies({required this.storage});

  @override
  final SharedPreferences storage;
}
