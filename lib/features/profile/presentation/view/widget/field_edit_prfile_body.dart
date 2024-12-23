import 'package:delivery_app_new/features/auth/presentation/widget/Custom_text_field_2.dart';
import 'package:flutter/material.dart';

class FieldEditPrfileBody extends StatelessWidget {
  const FieldEditPrfileBody({
    super.key,
    required this.title,
    required this.topPadding,
    required this.controller,
  });

  final String title;
  final double topPadding;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, top: topPadding),
      child: CustomTextField2(
        controller: controller,
        hintText: title,
        color: const Color(0xffFFFFFF),
        textColor: Colors.grey,
        obscureText: false,
      ),
    );
  }
}
