import 'package:flutter/material.dart';
import 'package:note_app/src/common/constants/app_colors.dart';

class TextFields extends StatefulWidget {
  final String infoText;
  final String exampleText;
  final bool? isObscure;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String? value)? validator;
  final TextEditingController controller;

  const TextFields({
    required this.controller,
    required this.validator,
    required this.textInputAction,
    required this.keyboardType,
    required this.infoText,
    required this.exampleText,
    this.isObscure,
    super.key,
  });

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool? showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.isObscure;
  }

  void changeObscure() {
    if (showPassword != null) {
      setState(() => showPassword = !showPassword!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.infoText,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: widget.controller,
                validator: widget.validator,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                obscuringCharacter: "•",
                obscureText: showPassword ?? false,
                decoration: InputDecoration(

                  errorStyle: const TextStyle(
                    color: AppColors.errorBorder,
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.white,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.fillColor,
                  suffixIcon: showPassword != null
                      ? GestureDetector(
                          onTap: changeObscure,
                          child: Icon(
                            showPassword!
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.iconColor,
                          ),
                        )
                      : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: widget.exampleText,
                  hintStyle: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 13,
                  ),
                ),
                showCursor: true,
                cursorColor: AppColors.white,
                style: const TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
