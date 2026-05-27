import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_text.dart';
import '../widgets/next_button.dart';
import '../widgets/scrollindicator.dart';
import '../widgets/skip_button.dart';
import '../widgets/sos_animation(1).dart';
import '../widgets/text_content.dart';
import 'OnboardingScreen2.dart';


class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive scaling
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;

    // Calculate proportional spacing (values based on 800pt screen height)
    const designHeight = 800.0;
    final scaleFactor = (screenHeight - topPadding) / designHeight;

    // Responsive spacing multipliers
    final double spacingAfterSkip = 140 * scaleFactor;
    final double spacingAfterSos = 140 * scaleFactor;
    final double spacingAfterText = 42 * scaleFactor;
    final double spacingAfterIndicator = 46 * scaleFactor;

    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top section with Skip button
                      const SkipButton(),

                      SizedBox(height: 60),
                      // Middle content (SOS + Text)

                      Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: SOSButton(),
                      ),

                      SizedBox(height: 130),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: TextContent(
                              title: AppStrings.on_1_title,
                              description: AppStrings.on_1_sub_title,
                            ),
                          ),


                      // Bottom section (Indicator + Next button)
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Column(
                          children: [
                            SizedBox(height: spacingAfterIndicator),
                            ScrollIndicator(currentIndex: 0),
                            SizedBox(height: spacingAfterIndicator),
                            NextButton(
                              text: AppStrings.Get_Started,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OnboardingScreen2(),
                                  ),
                                );
                              },
                            ),
                            // Add bottom padding for very short screens
                            SizedBox(height: spacingAfterSkip * 0.5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}