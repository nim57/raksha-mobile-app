import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_images.dart';
import 'package:mobileapp/features/auth/presentation/screens/permition_manage_screen.dart';
import 'package:mobileapp/features/onboarding/presentation/widgets/next_button.dart';

import '../../../../core/constants/app_text.dart';

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

    final List<TextEditingController> otpControllers =
    List.generate(6, (index) => TextEditingController());

    final List<FocusNode> focusNodes =
    List.generate(6, (index) => FocusNode());

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


                const SizedBox(height: 30),


                // Icon
                Container(
                  height: 200,
                  width: 200,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffb6797b).withValues(alpha: 0.2),
                  ),

                  child: Center(
                    child: Container(
                      height: 175,
                      width: 175,
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

                SizedBox(height: 60,),
                
                // text tile 
                Text(AppStrings.verifyYourNumber, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.onSurface),),
                const Text(AppStrings.weveSendCodeTo, style: TextStyle(fontSize: 16, color: AppColors.gray),),
                SizedBox(height: 5,),
                Text("+94 701990179", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface),),

                // otp text field

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: List.generate(
                    6,
                        (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),

                        height: 60,
                        width: 50,

                        child: TextField(

                          controller: otpControllers[index],
                          focusNode: focusNodes[index],

                          keyboardType: TextInputType.number,

                          maxLength: 2,

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),

                          decoration: InputDecoration(

                            counterText: "",

                            filled: true,

                            fillColor: Colors.transparent,


                            // rectangle border
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),

                              borderSide: const BorderSide(
                                color: AppColors.onSurface,
                                width: 1.5,
                              ),
                            ),


                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),

                              borderSide: const BorderSide(
                                color: AppColors.Terticry,
                                width: 1.5,
                              ),
                            ),

                          ),


                          onChanged: (value){

                            if(value.isNotEmpty && index < 5){

                              FocusScope.of(context)
                                  .requestFocus(
                                focusNodes[index + 1],
                              );

                            }


                            if(value.isEmpty && index > 0){

                              FocusScope.of(context)
                                  .requestFocus(
                                focusNodes[index - 1],
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                

                // timer
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.timer_1_copy, color: AppColors.Terticry,),
                    SizedBox(width: 8,),
                    Text(AppStrings.resendCodeIn , style: TextStyle(color: AppColors.gray),),
                    SizedBox(width: 8,),
                    Text("00.45", style: TextStyle(color: AppColors.Terticry, fontSize: 17),)
                  ],
                ),

                SizedBox(height: 25,),

                // resend section
                Text(AppStrings.didntReceiveCode, style: TextStyle(color: AppColors.gray),),
                Text(AppStrings.resendCode, style: TextStyle(color: AppColors.secondary, fontSize: 15),),

                SizedBox(height: 25,),
                // button

                NextButton( text: AppStrings.verifyCode, onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PermissionManageScreen()),
                  );
                },),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(
                    Iconsax.shield_tick_copy, 
                    color: AppColors.secondary,
                  ),
                    SizedBox(width: 5,),
                    Text(AppStrings.dataSecureMessage, style: TextStyle(color: AppColors.gray),),
                ],),


              ],
            ),
          ),
    );
  }
}