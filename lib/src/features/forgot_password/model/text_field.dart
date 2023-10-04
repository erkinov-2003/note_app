import 'package:flutter/material.dart';

class TextEdit extends StatefulWidget {
  final String? Function(String? value)? validateEmail;
  final String? value;
  final bool isPassword;
  final bool isRead;
  final TextEditingController controller;

  const TextEdit({
    Key? key,
    this.validateEmail,
    required this.value,
    required this.isPassword,
    required this.isRead,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextEdit> createState() => _TextEditState();
}

class _TextEditState extends State<TextEdit> {
  bool show = false;

  void showPassword() {
    show = !show;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    FocusNode focusNode = FocusNode();
    return TextFormField(
      controller: widget.controller,
      obscureText: !show && widget.isPassword,
      obscuringCharacter: "*",
      focusNode: focusNode,
      readOnly: widget.isRead,
      onTapOutside: (event) => focusNode.unfocus(),
      textInputAction: TextInputAction.send,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: theme.primaryColor,
      ),
      validator: widget.isRead ? null : widget.validateEmail,
      decoration: InputDecoration(
        hintText: widget.value,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: showPassword,
                style: IconButton.styleFrom(
                  elevation: 2,
                ),
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
        fillColor: theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: !widget.isRead ? Colors.white : Colors.transparent,
          ),
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
