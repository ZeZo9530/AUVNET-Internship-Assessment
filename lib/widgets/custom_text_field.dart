import 'package:flutter/material.dart';

//this is reusable textfield for the update product page
class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.hintText,
      this.onChanged,
      this.inputType,
      this.obscureText = false});
  final Function(String)? onChanged;
  final String? hintText;
  final TextInputType? inputType;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText!,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
