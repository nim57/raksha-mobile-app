import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  const ScrollIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}