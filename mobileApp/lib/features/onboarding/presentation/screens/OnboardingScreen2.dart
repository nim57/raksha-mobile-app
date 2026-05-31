import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/features/auth/presentation/screens/face-recognition-screen.dart';
import 'package:mobileapp/features/auth/presentation/screens/login_screen.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_text.dart';
import '../widgets/next_button.dart';
import '../widgets/scrollindicator.dart';
import '../widgets/text_content.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  bool _isLiveLocationEnabled = true;

  // // Colors from the original design


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [

                // Hero Section (replacing _buildHeroSection)
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: SizedBox(
                    height: 400,
                    child: Image.asset(AppImages.onboarding2 ),
                  ),
                ),


                TextContent(title: AppStrings.on_1_title, description: AppStrings.on_1_sub_title,),

                const SizedBox(height: 16),

                // Action Cards (replacing _buildActionCards)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Import Card
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Import contacts tapped')),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.glassBg,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white.withOpacity(0.08)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 32, offset: const Offset(0, 8)),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                                ),
                                child: const Icon(Icons.contact_emergency, color: AppColors.primary),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Import Emergency Contacts',
                                      style: GoogleFonts.inter(
                                        fontSize: 14, fontWeight: FontWeight.w700,
                                        color: AppColors.onSurface, letterSpacing: 0.7,
                                      ),
                                    ),
                                    Text(
                                      'Sync with your phone\'s address book',
                                      style: GoogleFonts.inter(fontSize: 13, color: AppColors.onSurfaceVariant),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant.withOpacity(0.5)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Location Toggle Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.glassBg,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 32, offset: const Offset(0, 8)),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
                              ),
                              child: const Icon(Icons.share_location, color: AppColors.secondary),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Live Location Sharing',
                                    style: GoogleFonts.inter(
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      color: AppColors.onSurface, letterSpacing: 0.7,
                                    ),
                                  ),
                                  Text(
                                    'Active only during alerts',
                                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _isLiveLocationEnabled,
                              onChanged: (value) => setState(() => _isLiveLocationEnabled = value),
                              activeColor: AppColors.secondary,
                              activeTrackColor: AppColors.secondary.withOpacity(0.4),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.white.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 52),

                // Scroll Indicator
                ScrollIndicator(currentIndex: 1),

                const SizedBox(height: 10), // bottom padding for fixed button

                // Next Button
                Padding(
                  padding: const EdgeInsets.only(top: 28.0, left:
                  18.0, right: 18.0),
                  child: NextButton(
                    text: AppStrings.next,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FaceRecognitionScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

