import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/constants/app_colors.dart';

class PermissionCard extends StatefulWidget {
  const PermissionCard({
    super.key,
    required this.isLocationTrackingOn,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onChanged,
  });

  final bool isLocationTrackingOn;
  final String title;
  final String subtitle;
  final IconData icon;
  final ValueChanged<bool>? onChanged;

  @override
  State<PermissionCard> createState() => _PermissionCardState();
}

class _PermissionCardState extends State<PermissionCard> {
  late bool isLocationTrackingOn;

  @override
  void initState() {
    super.initState();
    isLocationTrackingOn = widget.isLocationTrackingOn;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: 400,
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.Terticry,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: AppColors.onSurfaceVariant,
              size: 45,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: isLocationTrackingOn,
              onChanged: (bool value) {
                setState(() {
                  isLocationTrackingOn = value;
                });
                widget.onChanged?.call(value);
              },
              activeColor: Colors.white,
              activeTrackColor: AppColors.primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}