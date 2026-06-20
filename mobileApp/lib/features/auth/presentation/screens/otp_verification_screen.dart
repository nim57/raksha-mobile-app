import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_images.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.verificationMethod,
  });

  final String verificationMethod;

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.neutral,
      body:  Padding(
            padding: const EdgeInsets.only(top:  45, left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Back button
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
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),


                const SizedBox(height: 40),


                // Icon
                Container(
                  height: 190,
                  width: 190,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffb6797b).withValues(alpha: 0.2),
                  ),

                  child: Center(
                    child: Container(
                      height: 170,
                      width: 170,

                      decoration: const BoxDecoration(
                        color: Color(0xffFF2029),
                        shape: BoxShape.circle,
                      ),

                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.otp_icon,
                          height: 90,
                          width: 90,
                          fit: BoxFit.contain,
                        ),
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