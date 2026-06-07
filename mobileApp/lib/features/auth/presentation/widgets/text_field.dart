import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class Text_Field extends StatelessWidget {
  const Text_Field({
    super.key, required this.hintText, required this.hintIocn,
  });
  final String hintText;
  final IconData hintIocn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          prefixIcon:  Icon(
            hintIocn,
            color: AppColors.gray,
          ),


          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.gray, // Gray border color
              width: 1.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.secondary, // Green focus color
              width: 2,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}