import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Shape options available for decorative particles.
enum ParticleShape {
  square,
  diamond,
  circle,
  ring,
  triangle,
  star,
  plus,
}

/// Defines a single decorative particle: its shape, position, size,
/// rotation, color, and which pulse "lane" drives its animation.
class _ParticleSpec {
  const _ParticleSpec({
    required this.shape,
    required this.size,
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
    this.angle = 0,
    this.spin = false,
    this.lane = 0,
    this.minOpacity = 0.35,
    this.maxOpacity = 1.0,
    this.colorOpacity = 1.0,
    this.useWhite = false,
  });

  final ParticleShape shape;
  final double size;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  /// Static base rotation, in radians.
  final double angle;

  /// If true, the particle continuously rotates rather than just pulsing.
  final bool spin;

  /// Which pulse controller (0, 1, or 2) drives this particle's
  /// opacity/scale animation, so neighboring particles aren't in sync.
  final int lane;

  final double minOpacity;
  final double maxOpacity;

  /// Multiplier applied on top of [widget.color]'s own opacity.
  final double colorOpacity;

  /// If true, renders in white instead of the theme color (handy for
  /// "glint" particles against a colored badge).
  final bool useWhite;
}

/// A reusable success/confirmation animation widget.
///
/// Shows a checkmark badge with two expanding "glow ring" pulses
/// (staggered), plus a scattered burst of decorative particles in
/// varied shapes (squares, diamonds, circles, rings, triangles, stars,
/// pluses), sizes, and animation timings.
///
/// Usage:
/// ```dart
/// const SuccessAnimation()
/// ```
/// or customize size/colors:
/// ```dart
/// SuccessAnimation(
///   size: 320,
///   badgeSize: 148,
///   color: AppColors.primary,
///   particleDensity: ParticleDensity.high,
/// )
/// ```
class SuccessAnimation extends StatefulWidget {
  const SuccessAnimation({
    super.key,
    this.size = 320,
    this.badgeSize = 148,
    this.checkSize = 80,
    this.color = AppColors.primary,
    this.particleDensity = ParticleDensity.high,
  });

  /// Overall bounding box size of the animation (width = height).
  final double size;

  /// Diameter of the outer ring of the central badge.
  final double badgeSize;

  /// Size of the checkmark icon.
  final double checkSize;

  /// Primary color used for the badge, rings, and most particles.
  final Color color;

  /// How many decorative particles to scatter around the badge.
  final ParticleDensity particleDensity;

  @override
  State<SuccessAnimation> createState() => _SuccessAnimationState();
}

/// Controls how many decorative particles are drawn.
enum ParticleDensity { low, medium, high }

class _SuccessAnimationState extends State<SuccessAnimation>
    with TickerProviderStateMixin {
  late AnimationController _ringController1;
  late AnimationController _ringController2;

  // Three staggered pulse "lanes" so particles don't all twinkle in
  // lockstep — gives a more organic, sparkling feel.
  late AnimationController _laneA;
  late AnimationController _laneB;
  late AnimationController _laneC;

  // One slow continuous rotation controller for "spin"-tagged particles.
  late AnimationController _spinController;

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

    _laneA = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _laneB = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _laneB.repeat(reverse: true);
    });

    _laneC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    Future.delayed(const Duration(milliseconds: 550), () {
      if (mounted) _laneC.repeat(reverse: true);
    });

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat();
  }

  @override
  void dispose() {
    _ringController1.dispose();
    _ringController2.dispose();
    _laneA.dispose();
    _laneB.dispose();
    _laneC.dispose();
    _spinController.dispose();
    super.dispose();
  }

  AnimationController _laneController(int lane) {
    switch (lane) {
      case 1:
        return _laneB;
      case 2:
        return _laneC;
      default:
        return _laneA;
    }
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
                border: Border.all(color: widget.color, width: 2),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the raw shape (no animation wrapper) for a given spec.
  Widget _buildShape(_ParticleSpec spec) {
    final color = (spec.useWhite ? Colors.white : widget.color)
        .withOpacity(spec.colorOpacity.clamp(0.0, 1.0));

    switch (spec.shape) {
      case ParticleShape.square:
        return Container(width: spec.size, height: spec.size, color: color);

      case ParticleShape.diamond:
        return Transform.rotate(
          angle: 0.785398, // 45deg, on top of any spec.angle applied outside
          child: Container(
            width: spec.size,
            height: spec.size,
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 1.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );

      case ParticleShape.circle:
        return Container(
          width: spec.size,
          height: spec.size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        );

      case ParticleShape.ring:
        return Container(
          width: spec.size,
          height: spec.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
        );

      case ParticleShape.triangle:
        return CustomPaint(
          size: Size(spec.size, spec.size),
          painter: _TrianglePainter(color: color),
        );

      case ParticleShape.star:
        return CustomPaint(
          size: Size(spec.size, spec.size),
          painter: _StarPainter(color: color),
        );

      case ParticleShape.plus:
        return CustomPaint(
          size: Size(spec.size, spec.size),
          painter: _PlusPainter(color: color),
        );
    }
  }

  /// Wraps a particle shape with its opacity pulse and rotation.
  Widget _buildAnimatedParticle(_ParticleSpec spec) {
    final laneController = _laneController(spec.lane);

    return AnimatedBuilder(
      animation: Listenable.merge([laneController, _spinController]),
      builder: (context, _) {
        final pulse = laneController.value;
        final opacity =
            spec.minOpacity + ((spec.maxOpacity - spec.minOpacity) * pulse);
        final rotation = spec.angle +
            (spec.spin ? (_spinController.value * 2 * math.pi) : 0);

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.rotate(
            angle: rotation,
            child: _buildShape(spec),
          ),
        );
      },
    );
  }

  /// Full particle layout. Defined relative to a 320x320 canvas and
  /// scaled to [widget.size] at build time.
  List<_ParticleSpec> _allParticles() {
    final c = widget.color;

    final base = <_ParticleSpec>[
      // ---- Originals, kept for continuity ----
      const _ParticleSpec(
        shape: ParticleShape.square,
        size: 17,
        top: 5,
        right: 19,
        left: null,
        bottom: null,
        angle: 0.785398,
        lane: 0,
      ),
      const _ParticleSpec(
        shape: ParticleShape.diamond,
        size: 22,
        bottom: 21,
        left: 6,
        top: null,
        right: null,
        angle: 0.2094,
        lane: 1,
        minOpacity: 1,
        maxOpacity: 1,
      ),
      _ParticleSpec(
        shape: ParticleShape.circle,
        size: 20,
        bottom: -2,
        right: 47,
        top: null,
        left: null,
        useWhite: true,
        colorOpacity: 0.5,
        lane: 2,
        minOpacity: 1,
        maxOpacity: 1,
      ),

      // ---- Expanded burst ----
      const _ParticleSpec(
        shape: ParticleShape.circle,
        size: 12,
        top: 28,
        left: 14,
        right: null,
        bottom: null,
        lane: 1,
      ),
      const _ParticleSpec(
        shape: ParticleShape.square,
        size: 10,
        top: 130,
        left: -6,
        right: null,
        bottom: null,
        angle: 0.5236,
        lane: 1,
      ),
      const _ParticleSpec(
        shape: ParticleShape.ring,
        size: 14,
        top: 38,
        right: -4,
        left: null,
        bottom: null,
        lane: 0,
        minOpacity: 0.5,
      ),
      _ParticleSpec(
        shape: ParticleShape.circle,
        size: 9,
        bottom: 36,
        right: 4,
        top: null,
        left: null,
        colorOpacity: 0.6,
        lane: 0,
      ),
      const _ParticleSpec(
        shape: ParticleShape.square,
        size: 11,
        top: 150,
        right: -8,
        left: null,
        bottom: null,
        angle: 0.3927,
        lane: 0,
      ),
      const _ParticleSpec(
        shape: ParticleShape.diamond,
        size: 12,
        bottom: 4,
        left: 36,
        top: null,
        right: null,
        lane: 1,
        minOpacity: 0.5,
      ),
      _ParticleSpec(
        shape: ParticleShape.circle,
        size: 8,
        top: -4,
        left: 150,
        right: null,
        bottom: null,
        colorOpacity: 0.5,
        lane: 1,
      ),

      // ---- New shapes: star, triangle, plus, ring ----
      const _ParticleSpec(
        shape: ParticleShape.star,
        size: 18,
        top: 60,
        left: -10,
        right: null,
        bottom: null,
        spin: true,
        lane: 2,
        minOpacity: 0.5,
      ),
      const _ParticleSpec(
        shape: ParticleShape.star,
        size: 14,
        top: 0,
        right: 70,
        left: null,
        bottom: null,
        lane: 1,
        minOpacity: 0.4,
      ),
      const _ParticleSpec(
        shape: ParticleShape.triangle,
        size: 16,
        bottom: 60,
        left: -8,
        top: null,
        right: null,
        angle: -0.3,
        lane: 0,
        minOpacity: 0.45,
      ),
      const _ParticleSpec(
        shape: ParticleShape.triangle,
        size: 13,
        top: 90,
        right: -12,
        left: null,
        bottom: null,
        angle: 2.2,
        lane: 2,
        minOpacity: 0.4,
      ),
      const _ParticleSpec(
        shape: ParticleShape.plus,
        size: 16,
        top: 100,
        left: 6,
        right: null,
        bottom: null,
        lane: 2,
        minOpacity: 0.4,
      ),
      const _ParticleSpec(
        shape: ParticleShape.plus,
        size: 12,
        bottom: 80,
        right: 0,
        top: null,
        left: null,
        lane: 0,
        minOpacity: 0.4,
        spin: true,
      ),
      const _ParticleSpec(
        shape: ParticleShape.ring,
        size: 10,
        bottom: 100,
        left: 24,
        top: null,
        right: null,
        lane: 1,
        minOpacity: 0.5,
      ),
      _ParticleSpec(
        shape: ParticleShape.circle,
        size: 6,
        top: 70,
        right: 30,
        left: null,
        bottom: null,
        colorOpacity: 0.7,
        lane: 2,
      ),
      _ParticleSpec(
        shape: ParticleShape.circle,
        size: 7,
        bottom: 10,
        left: 90,
        top: null,
        right: null,
        useWhite: true,
        colorOpacity: 0.6,
        lane: 0,
      ),
      const _ParticleSpec(
        shape: ParticleShape.diamond,
        size: 9,
        top: 8,
        left: 90,
        right: null,
        bottom: null,
        lane: 2,
        minOpacity: 0.45,
      ),
    ];

    switch (widget.particleDensity) {
      case ParticleDensity.low:
        return base.take(3).toList();
      case ParticleDensity.medium:
        return base.take(10).toList();
      case ParticleDensity.high:
        return base;
    }
  }

  @override
  Widget build(BuildContext context) {
    final innerBadgeSize = widget.badgeSize * (120 / 148);
    final outerRingSize = widget.badgeSize * (192 / 148);
    final innerRingSize = widget.badgeSize * (160 / 148);

    // Scale factor relative to the 320px canvas the particle layout
    // was authored against, so the whole burst scales with `size`.
    final scale = widget.size / 320;

    double? scaled(double? v) => v == null ? null : v * scale;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _buildGlowRing(_ringController1, outerRingSize),
          _buildGlowRing(_ringController2, innerRingSize),

          // Central badge
          Container(
            width: widget.badgeSize,
            height: widget.badgeSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(0.1),
              border: Border.all(color: widget.color, width: 4),
            ),
            child: Center(
              child: Container(
                width: innerBadgeSize,
                height: innerBadgeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: widget.checkSize,
                ),
              ),
            ),
          ),

          // ---- Decorative particle burst ----
          for (final spec in _allParticles())
            Positioned(
              top: scaled(spec.top),
              left: scaled(spec.left),
              right: scaled(spec.right),
              bottom: scaled(spec.bottom),
              child: Transform.scale(
                scale: scale.clamp(0.5, 1.5),
                child: _buildAnimatedParticle(spec),
              ),
            ),
        ],
      ),
    );
  }
}

/// Paints a simple upward-pointing equilateral-ish triangle.
class _TrianglePainter extends CustomPainter {
  const _TrianglePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Paints a simple 4-pointed sparkle/star shape.
class _StarPainter extends CustomPainter {
  const _StarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    // 4-pointed star: long points top/bottom/left/right, short points
    // at the diagonals, for a classic "sparkle" look.
    final path = Path()
      ..moveTo(cx, 0)
      ..quadraticBezierTo(cx, cy, w, cy)
      ..quadraticBezierTo(cx, cy, cx, h)
      ..quadraticBezierTo(cx, cy, 0, cy)
      ..quadraticBezierTo(cx, cy, cx, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Paints a simple plus/cross shape.
class _PlusPainter extends CustomPainter {
  const _PlusPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final thickness = size.width * 0.28;
    final w = size.width;
    final h = size.height;

    final hRect = Rect.fromLTWH(0, (h - thickness) / 2, w, thickness);
    final vRect = Rect.fromLTWH((w - thickness) / 2, 0, thickness, h);

    canvas.drawRect(hRect, paint);
    canvas.drawRect(vRect, paint);
  }

  @override
  bool shouldRepaint(covariant _PlusPainter oldDelegate) =>
      oldDelegate.color != color;
}