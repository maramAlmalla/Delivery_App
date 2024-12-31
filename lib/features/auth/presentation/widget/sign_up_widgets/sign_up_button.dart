import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/widget/custom_button.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Sign Up',
      color: AppColors.darkTealBlue,
      onTap: () {
        CustomNavigationReplacement(context, "/MarketsPage");
      },
    );
  }
}
