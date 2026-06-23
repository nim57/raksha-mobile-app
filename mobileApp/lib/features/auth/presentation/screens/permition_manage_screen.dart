import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobileapp/core/constants/app_text.dart';
import 'package:mobileapp/features/auth/presentation/screens/verification-success-screen.dart';
import 'package:mobileapp/features/onboarding/presentation/widgets/next_button.dart';
import '../../../../core/constants/app_colors.dart';
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
              title: AppStrings.locationTrackingTitle,
              subtitle: AppStrings.locationTrackingSubtitle,
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
              title: AppStrings.wifiTitle,
              subtitle: AppStrings.wifiSubtitle,
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
              title: AppStrings.bluetoothTitle,
              subtitle: AppStrings.bluetoothSubtitle,
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
              title: AppStrings.hotspotTitle,
              subtitle: AppStrings.hotspotSubtitle,
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
              title: AppStrings.contactsTitle,
              subtitle: AppStrings.contactsSubtitle,
              icon: Iconsax.book_copy,
              onChanged: (value) {
                setState(() {
                  isContactsOn = value;
                });
              },
            ),

            SizedBox(height: 60),

            NextButton(
              text: AppStrings.allowAll,
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AccountCreatingSuccessScreen()),
                );

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