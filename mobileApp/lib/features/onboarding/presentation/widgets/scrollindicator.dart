// scrollindicator.dart
import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCount;

  const ScrollIndicator({
    super.key,
    required this.currentIndex,
    this.totalCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: isActive
                ? const LinearGradient(
              colors: [Color(0xFFFF5545), Color(0xFFFF8A6C)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
                : null,
            color: isActive ? null : const Color(0xFF353437).withOpacity(0.5),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: const Color(0xFFFF5545).withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ]
                : null,
          ),
        );
      }),
    );
  }
}