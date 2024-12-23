import 'package:delivery_app_new/core/utils/app_assets.dart';
import 'package:delivery_app_new/core/utils/app_string.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!)
          ..addListener(() {
            setState(() {
              if (animationController!.isCompleted) {
                animationController?.repeat(reverse: false);
              }
            });
          });
    animationController?.forward();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        Center(
          child: Container(
            width: 400,
            height: 300,
            decoration: const BoxDecoration(
              boxShadow: [],
              image: DecorationImage(
                image: AssetImage(Assets.onBoarding1),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Spacer(),
        FadeTransition(
          opacity: fadingAnimation!,
          child: Column(
            children: [
              const Text(
                AppString.appName,
                style: CustomTextStyle.parkinsans600Style28,
              ),
              Text(
                'DELIVERY MAN',
                style: CustomTextStyle.parkinsans300Style16,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
