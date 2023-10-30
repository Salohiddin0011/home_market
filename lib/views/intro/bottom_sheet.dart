import 'package:flutter/material.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomBottomSheet extends StatelessWidget {
  final PageController controller;
  const CustomBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(flex: 2),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 7,
                dotWidth: 10,
                dotHeight: 10,
                dotColor: Color(0xffD2E0FF),
                activeDotColor: AppColors.ff006EFF,
                type: WormType.normal,
              ),
            ),
          ),
          const Spacer(flex: 1),
          TextButton(
            onPressed: () {
              controller.animateToPage(3,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.linear);
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.ff006EFF),
            ),
          ),
        ],
      ),
    );
  }
}
