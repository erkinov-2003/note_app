import 'package:flutter/material.dart';
import '../../common/utils/storage.dart';
import '../../common/localization/generated/l10n.dart';

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
  final localization = GeneratedLocalization();

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

  void checkOldPassword() async {
    final correctOldPassword =
        await $secureStorage.read(key: StorageKeys.notesPassword.key);
    final enteredOldPassword =
        oldControllers.map((controller) => controller.text).join();

    setState(() {
      isOldPasswordCorrect = enteredOldPassword == correctOldPassword;
    });

    if (isOldPasswordCorrect) {
      if (mounted) FocusScope.of(context).requestFocus(focusNodes1[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isLandscape ? 600 : 450,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: isLandscape ? 20 : 50,
                    left: 22,
                    right: 22,
                    bottom: isLandscape ? 10 : 30,
                  ),
                  child: Text(
                    localization.updateSecretPass,
                    style: TextStyle(
                      fontSize: isLandscape ? 28 : 35,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ranade",
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 45),
                  child: Text(
                    localization.oldPassword,
                    style: TextStyle(
                      fontSize: isLandscape ? 13 : 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Ranade",
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isLandscape ? 10 : 25,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: size <= 340 ? 55 : size<=375? 70 : 80,
                        height: size <= 340 ? 55 : size<=375? 70 : 80,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color(0xff262629),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isOldPasswordCorrect
                                  ? const Color(0xff262629)
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              cursorHeight: 30,
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              controller: oldControllers[index],
                              focusNode: focusNodes[index],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                helperText: "",
                                helperStyle: TextStyle(
                                  color: Colors.transparent,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Ranade",
                                fontSize: 30,
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
                        ),
                      );
                    }),
                  ),
                ),
                if (isOldPasswordCorrect)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35, left: 25),
                        child: Text(
                          localization.setPassword2,
                          style: TextStyle(
                            fontSize: isLandscape ? 13 : 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Ranade",
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: isLandscape ? 10 : 25, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                width: size <= 340 ? 55 : size<=375? 70 : 80,
                                height: size <= 340 ? 55 : size<=375? 70 : 80,
                                child: ColoredBox(
                                  color: const Color(0xff262629),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      cursorHeight: 30,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      controller: newControllers[index],
                                      focusNode: focusNodes1[index],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        helperText: "",
                                        helperStyle: TextStyle(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Ranade",
                                        fontSize: 30,
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
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: isOldPasswordCorrect ? 215 : 350,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: !isOldPasswordCorrect
                          ? checkOldPassword
                          : () async {
                              final updatePass = newControllers
                                  .map((e) => e.text)
                                  .toList()
                                  .join("");
                              await $secureStorage.write(
                                key: StorageKeys.notesPassword.key,
                                value: updatePass,
                              );
                              if (mounted) Navigator.pop(context);
                            },
                      child: Text(
                        isOldPasswordCorrect
                            ? localization.setPassword
                            : localization.check,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isLandscape ? 16 : 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Ranade",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
