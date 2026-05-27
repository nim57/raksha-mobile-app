import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_text.dart';
import '../widgets/next_button.dart';
import '../widgets/scrollindicator.dart';
import '../widgets/skip_button.dart';
import '../widgets/sos_animation(1).dart';
import '../widgets/text_content.dart';
import 'OnboardingScreen2.dart' hide NextButton;

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.neutral,
      body: SafeArea(
        child: Column(
          children: [

           // ----- Skip Button -----
            SkipButton(),

            SizedBox(height: 140),

            // ----- Sos Animation  -----
            const SOSButton(),

            const SizedBox(height: 140),

            // Text content
            TextContent(title: AppStrings.on_1_title, description: AppStrings.on_1_sub_title,),

            const SizedBox(height: 42),

            // Scroll Indicator
            ScrollIndicator(currentIndex: 0,),

            const SizedBox(height: 46),

            // Next Button
            NextButton(
              text: AppStrings.Get_Started,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OnboardingScreen2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}





