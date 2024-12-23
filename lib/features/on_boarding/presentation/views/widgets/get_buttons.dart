import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_string.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:delivery_app_new/core/widget/Custom_button.dart';
import 'package:delivery_app_new/features/on_boarding/data/models/on_boarding_models.dart';
import 'package:delivery_app_new/features/on_boarding/presentation/views/functions/on_boarding.dart';
import 'package:flutter/material.dart';

class GetButtons extends StatelessWidget {
  final int currentIndex;

  const GetButtons(
      {super.key, required this.currentIndex, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    if (currentIndex == onBoardingData.length - 1) {
      return Column(
        children: [
          CustomButton(
            text: 'NEXT',
            color: AppColors.darkTealBlue,
            onTap: () {
              onBoardingVisited();
              CustomNavigationReplacement(context, '/SignInView');
            },
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              onBoardingVisited();
              CustomNavigationReplacement(context, '/SignUpView');
            },
            child: Text(
              AppString.newAccount,
              style: CustomTextStyle.parkinsans300Style16.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          CustomButton(
            color: AppColors.darkTealBlue,
            onTap: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn);
            },
            text: 'NEXT',
          ),
        ],
      );
    }
  }
}
