import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';
import 'package:flutter/material.dart';

class AppbarHomeView extends StatelessWidget {
  const AppbarHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: AppColors.darkTealBlue,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: Row(
            children: [
              CustomIconBotton(
                onPressed: () {
                  CustomNavigationReplacement(context, "/SearchView");
                },
                icons: const Icon(Icons.search),
                colors: AppColors.afwait,
              ),
              CustomIconBotton(
                onPressed: () {
                  CustomNavigationReplacement(context, "/CartView");
                },
                icons: const Icon(Icons.add_shopping_cart),
                colors: AppColors.afwait,
              ),
            ],
          ),
        ),
        Positioned(
          top: 100,
          left: 90,
          child: Text(
            'Delivery Man ',
            style: CustomTextStyle.parkinsans400Style16.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.tealGreen,
            ),
          ),
        ),
      ],
    );
  }
}
