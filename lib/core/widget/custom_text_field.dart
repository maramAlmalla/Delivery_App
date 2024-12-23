import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.color,
      required this.textColor,
      this.controller});
  final String hintText;
  final Icon icon;
  final Color color;
  final Color textColor;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.grey, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.grey, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 3),
            borderRadius: BorderRadius.circular(24),
          ),
          filled: true,
          fillColor: color,
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }
}
