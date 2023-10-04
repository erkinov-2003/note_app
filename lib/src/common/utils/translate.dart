import 'package:flutter/material.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';

class Translate extends StatelessWidget {
  const Translate({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    GeneratedLocalization localization,
    Widget? child,
  ) builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      builder(context, GeneratedLocalization.of(context), child);
}
