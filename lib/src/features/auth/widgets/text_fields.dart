import 'package:flutter/material.dart';

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
                color: Color(0xFF575758),
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
                    color: Color(0xFFB04F4F),
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF262629),
                  suffixIcon: showPassword != null
                      ? GestureDetector(
                          onTap: changeObscure,
                          child: Icon(
                            showPassword! ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF878787),
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
                    color: Color(0xFF575758),
                    fontSize: 13,
                  ),
                ),
                showCursor: true,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
