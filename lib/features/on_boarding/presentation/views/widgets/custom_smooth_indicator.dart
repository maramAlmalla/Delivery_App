import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSnoothPageIndicator extends StatelessWidget {
  const CustomSnoothPageIndicator({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.tealGreen,
        dotHeight: 7,
        dotWidth: 8,
      ),
    );
  }
}
