import 'package:flutter/material.dart';

class WelcomePageProvider extends InheritedWidget {
  final PageController pageController;

  const WelcomePageProvider(
    this.pageController, {
    super.key,
    required Widget child,
  }) : super(child: child);

  static WelcomePageProvider of(BuildContext context, {bool listen = false}) {
    if (listen) {
      final WelcomePageProvider? result =
          context.dependOnInheritedWidgetOfExactType<WelcomePageProvider>();
      assert(result != null, 'No WelcomePageProvider found in context');
      return result!;
    } else {
      return context
          .getElementForInheritedWidgetOfExactType<WelcomePageProvider>()!
          .widget as WelcomePageProvider;
    }
  }

  @override
  bool updateShouldNotify(WelcomePageProvider oldWidget) => false;
}
