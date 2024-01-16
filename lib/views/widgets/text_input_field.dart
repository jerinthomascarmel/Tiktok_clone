import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
    required this.icon,
    this.isObscure = false,
    required this.labeltext,
  });
  final TextEditingController controller;
  final String labeltext;
  final IconData icon;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labeltext,
          prefixIcon: Icon(icon),
          labelStyle: const TextStyle(fontSize: 20),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(5))),
      obscureText: isObscure,
    );
  }
}
