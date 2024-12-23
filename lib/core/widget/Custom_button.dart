import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap, required this.text, this.color});

  VoidCallback? onTap;
  String text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // هنا يتم تنفيذ الدالة onTap عند الضغط
      child: Container(
        width: 300,
        height: 45,
        decoration: BoxDecoration(
          color: color ?? Colors.blue, // إضافة قيمة افتراضية للون
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: CustomTextStyle.parkinsans300Style16
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
