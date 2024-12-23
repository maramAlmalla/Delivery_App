import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class CustomIconBotton extends StatelessWidget {
  const CustomIconBotton(
      {super.key,
      required this.onPressed,
      this.icons,
      this.colors,
      this.text,
      this.backgroundColor});
  final VoidCallback onPressed;
  final Icon? icons;
  final String? text;
  final Color? colors;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 20,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icons != null)
              Icon(
                icons!.icon,
                color: colors ?? Colors.white,
                size: 24,
              ),
            if (text != null)
              Text(
                text!,
                style: CustomTextStyle.parkinsans300Style16.copyWith(
                  color: colors ?? Colors.white,
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
