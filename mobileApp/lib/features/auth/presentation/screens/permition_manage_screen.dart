import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobileapp/features/onboarding/presentation/widgets/next_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../widgets/permission_card.dart';

class PermissionManageScreen extends StatefulWidget {
  const PermissionManageScreen({super.key});

  @override
  State<PermissionManageScreen> createState() => _PermitionManageScreenState();
}

class _PermitionManageScreenState extends State<PermissionManageScreen> {
  bool isLocationTrackingOn = false;
  bool isWifiOn = false;
  bool isBluetoothOn = true;
  bool isHotspotOn = false;
  bool isContactsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0, left: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white12,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Location card
            PermissionCard(
              isLocationTrackingOn: isLocationTrackingOn,
              title: 'Live Location Tracking',
              subtitle: "We're tracking live location allows",
              icon: Iconsax.location_copy,
              onChanged: (value) {
                setState(() {
                  isLocationTrackingOn = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Wi-Fi card
            PermissionCard(
              isLocationTrackingOn: isWifiOn,
              title: 'Wi-Fi',
              subtitle: "Use Wi-Fi when internet is not working",
              icon: Iconsax.wifi_copy,
              onChanged: (value) {
                setState(() {
                  isWifiOn = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Bluetooth card
            PermissionCard(
              isLocationTrackingOn: isBluetoothOn,
              title: 'Bluetooth',
              subtitle: "Use Bluetooth when internet is not working",
              icon: Iconsax.bluetooth_copy,
              onChanged: (value) {
                setState(() {
                  isBluetoothOn = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Hotspot card
            PermissionCard(
              isLocationTrackingOn: isHotspotOn,
              title: 'Hotspot',
              subtitle: "Use Hotspot when internet is not working",
              icon: Iconsax.global_copy,
              onChanged: (value) {
                setState(() {
                  isHotspotOn = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Contacts card
            PermissionCard(
              isLocationTrackingOn: isContactsOn,
              title: 'Allow Contacts',
              subtitle: "Access your contacts to find friends",
              icon: Iconsax.book_copy,
              onChanged: (value) {
                setState(() {
                  isContactsOn = value;
                });
              },
            ),

            SizedBox(height: 60),

            NextButton(
              text: "Allow All",
              onPressed: () {
                setState(() {
                  isLocationTrackingOn = true;
                  isWifiOn = true;
                  isBluetoothOn = true;
                  isHotspotOn = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}