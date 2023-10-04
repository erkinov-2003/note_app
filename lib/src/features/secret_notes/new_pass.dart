import 'package:flutter/material.dart';

import '../../common/localization/generated/l10n.dart';
import '../../common/models/note_model.dart';
import '../../common/utils/storage.dart';

class NewSecretPassword extends StatefulWidget {
  final NoteModel? note;
  final bool? isChecked;

  const NewSecretPassword({
    Key? key,
    this.note,
    this.isChecked,
  }) : super(key: key);

  @override
  NewSecretPasswordState createState() => NewSecretPasswordState();
}

class NewSecretPasswordState extends State<NewSecretPassword> {
  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;
  final localization = GeneratedLocalization();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isLandscape ? screenHeight * 0.04 : screenHeight * 0.1,
                  left: 22,
                  right: 22,
                  bottom: isLandscape ? 20 : 30,
                ),
                child: Text(
                  widget.note != null
                      ? "Enter Password"
                      : localization.newSecretPass,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Ranade",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: size <= 340
                            ? 55
                            : size <= 375
                                ? 70
                                : 80,
                        height: size <= 340
                            ? 55
                            : size <= 375
                                ? 70
                                : 80,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey,
                              )),
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                              cursorHeight: isLandscape ? 25 : 40,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              maxLength: 1,
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              decoration: const InputDecoration(
                                counter: SizedBox.shrink(),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Ranade",
                                fontSize: 30,
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
                      ),
                    );
                  }),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      final pass =
                          controllers.map((e) => e.text).toList().join("");
                      if (pass.isEmpty || pass.length < controllers.length) {
                        _showSnackbar(localization.snackBar);
                      } else {
                        if (widget.note == null) {
                          await $users.updateUser($users.currentUser
                              .copyWith(secretPassword: pass));
                          if (mounted) Navigator.pop(context, true);
                        } else {
                          if ($users.currentUser.secretPassword == pass) {
                            if (widget.isChecked != null) {
                              $users.currentUser.notes!.delete(widget.note!);
                            } else {
                              $users.currentUser.notes!
                                  .changeSecure(widget.note!);
                            }
                            if (mounted) Navigator.pop(context);
                          } else {
                            _showSnackbar(localization.snackBar2);
                          }
                        }
                      }
                    },
                    child: Text(
                      localization.setPassword,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Ranade",
                        fontSize: isLandscape ? 14 : 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
