import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final Function(String?)? onsave;
  final int? maxLines;
  final bool isPassword;
  final bool enable;
  final bool? check;
  final TextInputType? keyboardtype;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  Widget? prefix;
  Widget? suffix;

  CustomTextField(
      {this.controller,
      this.check,
      this.enable = true,
      this.focusNode,
      this.hintText,
      this.isPassword = false,
      this.keyboardtype,
      this.maxLines,
      this.onsave,
      this.prefix,
      this.suffix,
      this.textInputAction,
      this.validate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable == true ? true : enable,
      maxLines: maxLines == null ? 1 : maxLines,
      onSaved: onsave,
      focusNode: focusNode,
      controller: controller,
      textInputAction: textInputAction,
      obscureText: isPassword == false ? false : isPassword,
      keyboardType: keyboardtype == null ? TextInputType.name : keyboardtype,
      validator: validate,
      decoration: InputDecoration(
        suffixIcon: suffix,
        prefixIcon: prefix,
        labelText: hintText ?? "hint text..",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color(0xfffeaede),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.blueGrey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(255, 245, 19, 3),
          ),
        ),
      ),
    );
  }
}
