import 'package:delivery_app_new/core/utils/app_string.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final VoidCallback onTap;

  const CustomNavBar({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            AppString.skip,
            style: CustomTextStyle.parkinsans400Style12,
          ),
        ),
      ),
    );
  }
}
