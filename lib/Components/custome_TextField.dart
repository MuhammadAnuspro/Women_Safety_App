import 'package:flutter/material.dart';

class CustomeTextFeild extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String? Function(String?)? onsave;
  final int? maxLines;
  final bool? isPassword;
  final bool? enable;
  final bool? check;
  final TextInputType? keyboardType;
  final TextInputAction? textinputAction;
  final FocusNode? focusNode;
  final Widget? Prefix;
  final Widget? Suffix;
  CustomeTextFeild({
    this.controller,
    this.enable = true,
    this.focusNode,
    this.hintText,
    this.isPassword = false,
    this.maxLines,
    this.onsave,
    this.Prefix,
    this.Suffix,
    this.textinputAction,
    this.validate,
    this.keyboardType,
    this.check,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable == true ? true : enable,
      maxLines: maxLines == null ? 1 : maxLines,
      onSaved: onsave,
      focusNode: focusNode,
      controller: controller,
      textInputAction: textinputAction,
      keyboardType: keyboardType == null ? TextInputType.name : keyboardType,
      validator: validate,
      decoration: InputDecoration(
        suffixIcon: Suffix,
        prefixIcon: Prefix,
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
