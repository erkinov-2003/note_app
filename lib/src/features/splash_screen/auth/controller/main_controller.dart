import 'package:flutter/material.dart';

class MainController with ChangeNotifier {
  late PageController pageController;
  int pageNumber = 1;
  bool isRegistration = true;

  MainController({
    required this.pageController,
  });

  void onTap(int pageNumber) {
    pageController.animateToPage(
      pageNumber,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void onTap2() {
    if (isRegistration) {
      pageNumber = 2;
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = false;
     notifyListeners();
    } else if (!isRegistration) {
      pageNumber = 1;
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isRegistration = true;
      notifyListeners();
    }
  }
}

class Provider extends InheritedNotifier<MainController> {
  const Provider({
    required super.child,
    required final MainController controller,
    super.key,
  }) : super(notifier: controller);

  static MainController of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen)?.notifier ?? _noInheritedWidgetError();

  static Provider? maybeOf(BuildContext context, {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<Provider>()
          : context
          .getElementForInheritedWidgetOfExactType<Provider>()
          ?.widget as Provider?;

  static Never _noInheritedWidgetError() =>
      throw ArgumentError(
        'Not found InheritedWidget of type Provider',
        'out_of_scope',
      );
}