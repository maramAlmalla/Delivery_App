import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:flutter/widgets.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/image/delivery man logo.jpeg.png',
            width: 250,
            height: 250,
          ),
        ),
        Text(
          'Delivery Man',
          style: CustomTextStyle.parkinsans600Style28
              .copyWith(color: AppColors.tealGreen, fontSize: 35),
        ),
      ],
    );
  }
}
