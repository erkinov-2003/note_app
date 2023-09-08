import 'package:flutter/material.dart';

class TextEdit extends StatefulWidget {
  final String? Function(String? value) validateEmail;
  final String value;
  final bool isPassword;
  final bool isRead;

  const TextEdit({
    Key? key,
    required this.validateEmail,
    required this.value,
    required this.isPassword,
    required this.isRead,
  }) : super(key: key);

  @override
  State<TextEdit> createState() => _TextEditState();
}

class _TextEditState extends State<TextEdit> {
  bool show = true;

  void showPassword() {
    show = !show;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return TextFormField(
      obscureText: show && widget.isPassword,
      obscuringCharacter: "*",
      focusNode: focusNode,
      readOnly: widget.isRead,
      onTapOutside: (event) => focusNode.unfocus(),
      textInputAction: TextInputAction.send,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      validator: widget.isRead ? null : widget.validateEmail,
      decoration: InputDecoration(
        hintText: widget.value,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: showPassword,
                icon: Icon(
                  show ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : null,
        hintStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF575758),
        ),
        filled: true,
        fillColor: const Color(0xFFF262629),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
