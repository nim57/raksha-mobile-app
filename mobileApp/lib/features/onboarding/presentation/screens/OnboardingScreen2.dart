import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Colors from the original design
  static const Color primary = Color(0xFFFFB4AA);
  static const Color primaryContainer = Color(0xFFFF5545);
  static const Color secondary = Color(0xFFFFBC7C);
  static const Color surface = Color(0xFF131315);
  static const Color onSurface = Color(0xFFE4E2E4);
  static const Color onSurfaceVariant = Color(0xFFE7BDB7);
  static const Color tertiary = Color(0xFFADC6FF);
  static const Color glassBg = Color(0x661F1F21); // 0.4 opacity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,
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
                            color: glassBg,
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
                                  color: primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: primary.withOpacity(0.2)),
                                ),
                                child: const Icon(Icons.contact_emergency, color: primary),
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
                                        color: onSurface, letterSpacing: 0.7,
                                      ),
                                    ),
                                    Text(
                                      'Sync with your phone\'s address book',
                                      style: GoogleFonts.inter(fontSize: 13, color: onSurfaceVariant),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: onSurfaceVariant.withOpacity(0.5)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Location Toggle Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: glassBg,
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
                                color: secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: secondary.withOpacity(0.2)),
                              ),
                              child: const Icon(Icons.share_location, color: secondary),
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
                                      color: onSurface, letterSpacing: 0.7,
                                    ),
                                  ),
                                  Text(
                                    'Active only during alerts',
                                    style: GoogleFonts.inter(fontSize: 13, color: onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _isLiveLocationEnabled,
                              onChanged: (value) => setState(() => _isLiveLocationEnabled = value),
                              activeColor: secondary,
                              activeTrackColor: secondary.withOpacity(0.4),
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
                NextButton(
                  text: AppStrings.next,
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


        ],
      ),
    );
  }
}

