import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:delivery_app_new/features/on_boarding/data/models/on_boarding_models.dart';
import 'package:delivery_app_new/features/on_boarding/presentation/views/widgets/custom_smooth_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingWidgetBody extends StatelessWidget {
  const OnBoardingWidgetBody(
      {super.key, required this.controller, this.onPageChanged});
  final PageController controller;
  final Function(int)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        onPageChanged: onPageChanged,
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: onBoardingData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 64,
              ),
              Container(
                height: 290,
                width: 343,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(onBoardingData[index].imagePath),
                        fit: BoxFit.fill)),
              ),
              CustomSnoothPageIndicator(
                controller: controller,
              ),
              const SizedBox(
                height: 19,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  onBoardingData[index].title,
                  style: CustomTextStyle.parkinsans500Style24,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
