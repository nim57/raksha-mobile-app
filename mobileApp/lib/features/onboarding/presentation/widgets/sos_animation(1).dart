import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SOSButton extends StatefulWidget {
  const SOSButton({super.key});

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulse rings
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final value = _pulseController.value;
                final t1 = value % 1.0;
                final scale1 = 1.0 + (t1 * 1.2);
                final opacity1 = 0.6 * (1.0 - t1);
                final t2 = (value + 0.5) % 1.0;
                final scale2 = 1.0 + (t2 * 1.2);
                final opacity2 = 0.6 * (1.0 - t2);
                return Stack(
                  children: [
                    Opacity(
                      opacity: opacity1.clamp(0.0, 0.6),
                      child: Transform.scale(
                        scale: scale1,
                        child: Container(
                          width: 192,
                          height: 192,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFF5545), width: 4),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: opacity2.clamp(0.0, 0.6),
                      child: Transform.scale(
                        scale: scale2,
                        child: Container(
                          width: 192,
                          height: 192,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFF5545), width: 4),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Main SOS button with press animation
            GestureDetector(
              onTapDown: (_) {
                setState(() => _isPressed = true);
                HapticFeedback.mediumImpact();
              },
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: () {
                debugPrint('SOS button tapped');
                // Add your SOS action here
              },
              child: AnimatedScale(
                scale: _isPressed ? 0.98 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 192,
                  height: 192,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF5545), Color(0xFFD32F2F)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(6, 6),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: const Color(0xFFFF5545).withOpacity(0.2),
                        offset: const Offset(-2, -2),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Inner highlight
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.white.withOpacity(0.2), Colors.transparent],
                            ),
                          ),
                        ),
                      ),
                      // SOS text
                      Center(
                        child: Text(
                          'SOS',
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}