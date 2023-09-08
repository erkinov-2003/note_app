import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late final List<TextEditingController> oldControllers;
  late final List<TextEditingController> newControllers;
  late final List<FocusNode> focusNodes;
  late final List<FocusNode> focusNodes1;
  bool isOldPasswordCorrect = false;

  @override
  void initState() {
    super.initState();
    oldControllers = List.generate(4, (index) => TextEditingController());
    newControllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
    focusNodes1 = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in oldControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in newControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes1) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void checkOldPassword() {
    // In this example, I assume that the correct old password is "1234".
    final correctOldPassword = "1234";
    final enteredOldPassword = oldControllers
        .map((controller) => controller.text)
        .join(); // Combine the digits entered by the user.

    setState(() {
      isOldPasswordCorrect = enteredOldPassword == correctOldPassword;
    });

    if (isOldPasswordCorrect) {
      // If the old password is correct, focus on the first field of the new password.
      FocusScope.of(context).requestFocus(focusNodes1[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding:
              EdgeInsets.only(top: 50.0, left: 22, right: 22, bottom: 30),
              child: Text(
                "Update your secret Notes password",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Ranade",
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, top: 45),
              child: Text(
                "Your old password",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Ranade",
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xff262629),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isOldPasswordCorrect ? const Color(0xff262629) : Colors.red,
                          width: 2,
                        )
                      ),
                      child: TextField(
                        cursorColor: Colors.lightBlueAccent,
                        cursorHeight: 40,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        controller: oldControllers[index],
                        focusNode: focusNodes[index],
                        decoration: const InputDecoration(
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
                            if (index < oldControllers.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            }
                          } else if (text.isEmpty) {
                            if (index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index - 1]);
                            }
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
            if (isOldPasswordCorrect)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 35),
                    child: Text(
                      "Set new password",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Ranade",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
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
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                controller: newControllers[index],
                                focusNode: focusNodes1[index],
                                decoration: const InputDecoration(
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
                                    if (index < newControllers.length - 1) {
                                      FocusScope.of(context).requestFocus(
                                          focusNodes1[index + 1]);
                                    }
                                  } else if (text.isEmpty) {
                                    if (index > 0) {
                                      FocusScope.of(context).requestFocus(
                                          focusNodes1[index - 1]);
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
                ],
              ),
            Padding(
              padding:
               EdgeInsets.only(left: 25, right: 25, top: isOldPasswordCorrect? 215 : 350),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: checkOldPassword,
                  child: Text( isOldPasswordCorrect?
                    "Set Password": "Check",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
    );
  }
}

