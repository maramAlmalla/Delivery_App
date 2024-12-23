import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/service/servise_locator.dart';
import 'package:delivery_app_new/features/splash/presentation/view/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    bool isOnBoardingVisited =
        getIt<CashHelper>().getData(key: "isOnBoardingVisited") ?? false;
    if (isOnBoardingVisited == true) {
      delayedNavigate(context, "/SignUpView");
    } else {
      delayedNavigate(context, '/onBoarding');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}

void delayedNavigate(context, path) {
  Future.delayed(
      const Duration(
        seconds: 2,
      ), () {
    CustomNavigationReplacement(context, '/onBoarding');
  });
}
