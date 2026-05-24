import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/sos_animation(1).dart';

void main() => runApp(const MaterialApp(home: OnboardingScreen1()));

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    const marginMobile = 20.0;
    const touchTarget = 56.0;

    return Scaffold(
      backgroundColor: const Color(0xFF131315),
      body: SafeArea(
        child: Column(
          children: [
            // ----- Fixed Header -----
            Padding(
              padding: const EdgeInsets.only(left: 318.0, top: 20),
              child: GestureDetector(
                onTap: () => debugPrint('Skip tapped'),
                child: Text(
                  'Skip',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                    color: const Color(0xFFE7BDB7),
                  ),
                ),
              ),
            ),

            SizedBox(height: 140),

            // ----- Sos Animation  -----
            const SOSButton(),

            const SizedBox(height: 140),

            // ----- Footer -----

            // Text content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Instant Emergency Response',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: const Color(0xFFE4E2E4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'One tap to alert emergency services and your trusted contacts instantly.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: const Color(0xFFE7BDB7),
                    ),
                  ),


                  const SizedBox(height: 42),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5545),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF353437),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF353437),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 46),

                  // button
                  GestureDetector(
                    child: AnimatedScale(
                      scale: 0.96 ,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFF5545), Color(0xFFD32F2F)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}



