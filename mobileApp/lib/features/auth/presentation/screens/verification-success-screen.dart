import 'package:flutter/material.dart';

class AccountCreatingSuccessScreen extends StatefulWidget {
  const AccountCreatingSuccessScreen({super.key});

  @override
  State<AccountCreatingSuccessScreen> createState() =>
      _AccountCreatingSuccessScreenState();
}

class _AccountCreatingSuccessScreenState
    extends State<AccountCreatingSuccessScreen>
    with TickerProviderStateMixin {
  static const Color apexRed = Color(0xFFFF3B30);
  static const Color apexCharcoal = Color(0xFF131315);

  late AnimationController _ringController1;
  late AnimationController _ringController2;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _ringController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _ringController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _ringController2.repeat();
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ringController1.dispose();
    _ringController2.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildGlowRing(AnimationController controller, double baseSize) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = controller.value;
        final scale = 0.99 + (0.8 * t);
        final opacity = 0.8 * (1 - t);
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: baseSize,
              height: baseSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: apexRed, width: 2),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apexCharcoal,
      body: Center(
        child: SizedBox(
          width: 320,
          height: 320,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildGlowRing(_ringController1, 192),
              _buildGlowRing(_ringController2, 160),

              // Central badge
              Container(
                width: 148,
                height: 148,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: apexRed.withOpacity(0.1),
                  border: Border.all(color: apexRed, width: 4),
                ),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: apexRed,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
              ),


              // Decorative particles
              Positioned(
                top: 4,
                right: 4,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, _) => Opacity(
                    opacity: 0.4 + (0.6 * _pulseController.value),
                    child: Transform.rotate(
                      angle: 0.785398, // 45deg
                      child: Container(
                        width: 15,
                        height: 15,
                        color: apexRed,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 0,
                child: Transform.rotate(
                  angle: 0.2094, // 12deg
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      border: Border.all(color: apexRed, width: 1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -8,
                right: 24,
                child: Container(
                  width: 20,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}