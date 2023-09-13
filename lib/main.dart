import 'dart:async';

import 'package:flutter/material.dart';

import 'src/common/widget/app.dart';

void main() {

  final value = ValueNotifier<double>(0.0);
  final Timer? timer;

  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: SizedBox.square(
                dimension: 50,
                child: ValueListenableBuilder(
                  valueListenable: value,
                  builder: (context, v, child) {
                    return CircularProgressIndicator(
                      value: v,
                    );
                  }
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: value,
                builder: (context, v, child) {
                  return Text(v.toStringAsFixed(2));
                }
              ),
            ),
          ),
        ],
      ),
    ),
  ));

  // late final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  timer = Timer.periodic(const Duration(seconds: 1), (_) {
    value.value += 0.2;
  });

  Future.delayed(
    const Duration(seconds: 5),
        () {
      timer?.cancel();

      // binding.addPostFrameCallback((_) {
      //   binding.allowFirstFrame();
      // });

      runApp(const App());
    },
  ).ignore();
}
