import 'package:flutter/material.dart';


import '../../features/forgot_password/model/model.dart';
import '../../features/forgot_password/widget/forgot.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotWithModel(),
    );
  }
}

class ForgotWithModel extends StatefulWidget {
  const ForgotWithModel({Key? key}) : super(key: key);

  @override
  State<ForgotWithModel> createState() => _ForgotWithModelState();
}

class _ForgotWithModelState extends State<ForgotWithModel> {
  late Model model;

  @override
  void initState() {
    super.initState();
    model = Model(email: "");
  }

  @override
  void dispose() {
    super.dispose();
    model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: Forgot(),
      model: model,
    );
  }
}
