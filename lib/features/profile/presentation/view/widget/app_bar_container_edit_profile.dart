import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBarContainerEditProfile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const AppBarContainerEditProfile(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.darkTealBlue,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 30),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.afwait,
          onPressed: onPressed,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 75),
        child: Text(
          title,
          style: CustomTextStyle.parkinsans500Style24
              .copyWith(color: AppColors.tealGreen, fontSize: 30),
        ),
      )
    ]);
  }
}
