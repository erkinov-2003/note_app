import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    required this.progress,
    super.key,
  });

  final ValueNotifier<({int percent, String message})> progress;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: SizedBox.square(
                    dimension: 50,
                    child: ValueListenableBuilder(
                      valueListenable: progress,
                      builder: (context, value, child) {
                        return CircularProgressIndicator(
                          value: (value.percent / 100),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: progress,
                    builder: (context, value, child) {
                      return Text(value.message);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
