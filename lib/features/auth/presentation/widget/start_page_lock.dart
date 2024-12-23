import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class StartPageLock extends StatelessWidget {
  const StartPageLock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.lock, size: 120, color: AppColors.darkTealBlue),
            const SizedBox(height: 20),
            Text(
              "Forgot",
              textAlign: TextAlign.center,
              style: CustomTextStyle.parkinsans600Style28
                  .copyWith(fontSize: 50, color: AppColors.darkTealBlue),
            ),
            Text(
              "Password?",
              textAlign: TextAlign.center,
              style: CustomTextStyle.parkinsans600Style28
                  .copyWith(fontSize: 25, color: AppColors.darkTealBlue),
            ),
            const SizedBox(height: 10),
            Text("No worries, we’ll send you\nreset instructions",
                textAlign: TextAlign.center,
                style: CustomTextStyle.parkinsans400Style12.copyWith(
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
