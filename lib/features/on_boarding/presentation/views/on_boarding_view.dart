import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/features/on_boarding/presentation/views/functions/on_boarding.dart';
import 'package:delivery_app_new/features/on_boarding/presentation/views/widgets/custom_nav_par.dart';
import 'package:delivery_app_new/features/on_boarding/presentation/views/widgets/get_buttons.dart';
import 'package:delivery_app_new/features/on_boarding/presentation/views/widgets/on_boarding_widget_view.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 44,
              ),
              CustomNavBar(
                onTap: () {
                  onBoardingVisited();
                  CustomNavigationReplacement(context, '/SignUpView');
                },
              ),
              OnBoardingWidgetBody(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: _controller,
              ),
              const SizedBox(
                height: 100,
              ),
              GetButtons(
                currentIndex: currentIndex,
                controller: _controller,
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
