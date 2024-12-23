import 'package:delivery_app_new/core/utils/app_assets.dart';

class OnBoardingModels {
  final String imagePath;
  final String title;

  OnBoardingModels({required this.imagePath, required this.title});
}

List<OnBoardingModels> onBoardingData = [
  OnBoardingModels(
    imagePath: Assets.onBoarding1,
    title:
        "Shop everything you need in one place! Explore a world of products with Delivery Man",
  ),
  OnBoardingModels(
    imagePath: Assets.onBoarding2,
    title:
        "Turn your items into earnings! Sell your products effortlessly with Delivery Man",
  ),
  OnBoardingModels(
    imagePath: Assets.onBoarding3,
    title:
        "Get your favorite items delivered from anywhere to anywhere with ease",
  ),
];
