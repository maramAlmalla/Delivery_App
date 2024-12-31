import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.darkTealBlue,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's",
                  style: CustomTextStyle.parkinsans500Style24
                      .copyWith(color: AppColors.tealGreen, fontSize: 25)),
              Text("Create Your",
                  style: CustomTextStyle.parkinsans500Style24
                      .copyWith(color: AppColors.tealGreen, fontSize: 25)),
              Text("Account",
                  style: CustomTextStyle.parkinsans500Style24
                      .copyWith(color: AppColors.tealGreen, fontSize: 25)),
            ],
          ),
        ),
        Positioned(
          top: 30,
          right: 16,
          child: GestureDetector(
            onTap: () {
              CustomNavigationReplacement(context, '/Main');
            },
            child: Text('Skip',
                style: CustomTextStyle.parkinsans300Style16
                    .copyWith(color: AppColors.afwait)),
          ),
        ),
      ],
    );
  }
}
