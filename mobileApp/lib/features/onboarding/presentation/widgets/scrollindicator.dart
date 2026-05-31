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
        return Row(
          children: [
            Container(
              width: isActive ? 42 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFFF5545)
                    : const Color(0xFF4A4A4A),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            if (index != totalCount - 1) const SizedBox(width: 8),
          ],
        );
      }),
    );
  }
}