import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

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
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.12,
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
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscuringCharacter: "•",
            obscureText: showPassword ?? false,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(horizontal: size.height * 0.01),
              errorStyle: const TextStyle(
                color: AppColors.errorBorder,
                fontSize: 12,
                fontWeight: FontWeight.w100,
              ),
              enabledBorder:  const OutlineInputBorder(
                borderSide: BorderSide(
                  color:  AppColors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
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
            style:  TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
