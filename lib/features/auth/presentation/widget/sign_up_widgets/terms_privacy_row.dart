import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class TermsAndPrivacyRow extends StatelessWidget {
  const TermsAndPrivacyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
          activeColor: AppColors.tealGreen,
        ),
        Text(
          "I agree to the Terms & Privacy",
          style: CustomTextStyle.parkinsans300Style16.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}
