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
            Container(
              height: touchTarget,
              padding: const EdgeInsets.symmetric(horizontal: marginMobile),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1B1D).withOpacity(0.6),
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shield, color: const Color(0xFFFFB4AA), size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'GUARDIAN SOS',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: const Color(0xFFFFB4AA),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
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
                ],
              ),
            ),

            // ----- Extracted SOS Button Widget -----
            const SOSButton(),

          ],
        ),
      ),
    );
  }
}