import 'package:flutter/material.dart';

class SplashProvider extends InheritedWidget {
  const SplashProvider({
    required this.pageController,
    required super.child,
    super.key,
  });

  final PageController pageController;

  static SplashProvider of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen) ?? _noInheritedWidgetError();

  static SplashProvider? maybeOf(BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<SplashProvider>()
      : context.getElementForInheritedWidgetOfExactType<SplashProvider>()?.widget as SplashProvider?;

  static Never _noInheritedWidgetError() => throw ArgumentError(
    'Not found InheritedWidget of type Provider',
    'out_of_scope',
  );

  @override
  bool updateShouldNotify(SplashProvider oldWidget) => false;
}

