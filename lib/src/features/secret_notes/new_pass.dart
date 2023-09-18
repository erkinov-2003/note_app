import 'package:flutter/material.dart';

class NewSecretPassword extends StatefulWidget {
  const NewSecretPassword({Key? key}) : super(key: key);

  @override
  NewSecretPasswordState createState() => NewSecretPasswordState();
}

class NewSecretPasswordState extends State<NewSecretPassword> {
  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 22, right: 22, bottom: 30),
                  child: Text(
                    "Create your secret\nNotes password",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ranade",
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: ColoredBox(
                            color: const Color(0xff262629),
                            child: TextField(
                              cursorColor: Colors.lightBlueAccent,
                              cursorHeight: 40,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              decoration: const InputDecoration(
                                helperText: "",
                                helperStyle: TextStyle(
                                  color: Colors.transparent,
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Ranade",
                                fontSize: 35,
                              ),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  if (index < controllers.length - 1) {
                                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                                  }
                                } else if (text.isEmpty) {
                                  if (index > 0) {
                                    FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 330),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Set Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Ranade",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
