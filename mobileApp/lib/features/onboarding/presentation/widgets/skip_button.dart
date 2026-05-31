import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_text.dart';
import '../../../../core/constants/app_text_styles.dart';


class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 318.0, top: 20),
      child: GestureDetector(
        onTap: () {
          // Replace with real navigation logic
          debugPrint('Skip tapped');
          // Navigator.pushReplacement(context, ...);
        },
        child: Text(
          AppStrings.skip,
          style: AppTextStyles.skipButton(context),
        ),
      ),
    );
  }
}

