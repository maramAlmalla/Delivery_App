import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.icon,
    required this.color,
    required this.textColor,
    this.label,
    this.labelColor = Colors.grey,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.validator,
  });

  final String? hintText;
  final Icon? icon;
  final Color color;
  final Color textColor;
  final String? label;
  final Color labelColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          label: label != null
              ? Text(
                  label!,
                  style: CustomTextStyle.parkinsans300Style16.copyWith(
                    color: labelColor,
                    fontSize: 12,
                  ),
                )
              : null,
          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: icon,
                )
              : null,
          hintText: hintText,
          hintStyle: CustomTextStyle.parkinsans300Style16
              .copyWith(color: Colors.grey, fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          filled: true,
          fillColor: color,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }
}
