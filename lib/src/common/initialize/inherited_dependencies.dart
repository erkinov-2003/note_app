import 'package:flutter/material.dart';

import '../models/dependencies.dart';

class InheritedDependencies extends InheritedWidget {
  const InheritedDependencies({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final Dependencies dependencies;

  static Dependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  static Dependencies? maybeOf(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType<InheritedDependencies>()?.widget as InheritedDependencies?)?.dependencies;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
    "Out of scope, not found inherited widget "
        "a InheritedDependencies of the exact type",
    "out_of_scope",
  );

  @override
  bool updateShouldNotify(InheritedDependencies oldWidget) => false;
}
