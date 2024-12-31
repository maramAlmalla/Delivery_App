import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SignInRedirect extends StatelessWidget {
  const SignInRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an account? ",
          style: CustomTextStyle.parkinsans300Style16.copyWith(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            CustomNavigationReplacement(context, '/SignInView');
          },
          child: Text(
            "SIGN IN ",
            style: CustomTextStyle.parkinsans300Style16
                .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
