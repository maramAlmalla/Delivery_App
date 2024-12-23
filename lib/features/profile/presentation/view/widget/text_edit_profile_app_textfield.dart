import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class TextEditProfileAppTextfield extends StatelessWidget {
  const TextEditProfileAppTextfield(
      {super.key, required this.title, required this.topPadding});
  final String title;
  final double topPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 15, top: topPadding),
      child: Text(
        title,
        style: CustomTextStyle.parkinsans300Style16
            .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
