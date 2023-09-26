import 'package:flutter/material.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/features/profile/profile_page.dart';

class NewSecretPassword extends StatefulWidget {
  const NewSecretPassword({Key? key}) : super(key: key);

  @override
  NewSecretPasswordState createState() => NewSecretPasswordState();
}

class NewSecretPasswordState extends State<NewSecretPassword> {
  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;
  final localization = GeneratedLocalization();

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
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.1,
                    left: 22,
                    right: 22,
                    bottom: 30,
                  ),
                  child: Text(
                    localization.newSecretPass,
                    style: TextStyle(
                      fontSize: isLandscape ? 28 : 35,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ranade",
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isLandscape ? 30 : 60,
                    horizontal: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: isLandscape ? 60 : 80,
                          height: isLandscape ? 60 : 80,
                          child: ColoredBox(
                            color: const Color(0xff262629),
                            child: TextField(
                              cursorColor: Colors.lightBlueAccent,
                              cursorHeight: isLandscape ? 30 : 40,
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
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Ranade",
                                fontSize: isLandscape ? 24 : 35,
                              ),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  if (index < controllers.length - 1) {
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
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: isLandscape ? screenHeight * 0.15 : screenHeight * 0.44,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () async {
                        final pass =
                        controllers.map((e) => e.text).toList().join("");
                        await $secureStorage.write(
                            key: StorageKeys.notesPassword.key, value: pass);
                        if (mounted) Navigator.pop(context);
                      },
                      child: Text(
                        localization.setPassword,
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
        ),
      ),
    );
  }
}

