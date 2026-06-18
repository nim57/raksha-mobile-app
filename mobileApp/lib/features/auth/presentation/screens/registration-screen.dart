import 'package:flutter/material.dart';
import 'package:mobileapp/features/onboarding/presentation/widgets/next_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../widgets/text_field.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: SingleChildScrollView(
        child:

            // back arrow
          // Logo
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xff0A7A43),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Raksha",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0A7A43),
                      ),
                    ),
                  ],
                ),
                
                const Text(AppStrings.create_account, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.onSurface),),

                const Text(AppStrings.sign_up_to_get_started, style: TextStyle(fontSize: 16, color: AppColors.onSurface),),

                const SizedBox(height: 40,),


                Padding(
                  padding: const EdgeInsets.only(right: 25.0, left: 25),
                  child:Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.FULL_NAME,
                          style: TextStyle(fontWeight: FontWeight.w600,  color: AppColors.onSurface),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      const Text_Field(hintText: AppStrings.enter_full_name, hintIocn: Icons.person_outline),
                      const SizedBox(height: 16,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.email_address,
                          style: TextStyle(fontWeight: FontWeight.w600,  color: AppColors.onSurface),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      const Text_Field(hintText: AppStrings.enter_email, hintIocn: Icons.email_outlined),
                      const SizedBox(height: 16,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.phone_number,
                          style: TextStyle(fontWeight: FontWeight.w600,  color: AppColors.onSurface),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      const Text_Field(hintText: AppStrings.enter_phone_number, hintIocn: Icons.phone_outlined  ),
                      const SizedBox(height: 16,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.create_password,
                          style: TextStyle(fontWeight: FontWeight.w600,  color: AppColors.onSurface),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      const Text_Field(hintText: AppStrings.enter_password, hintIocn: Icons.lock_outline  ),
                      const SizedBox(height: 30,),
                      const Row(
                        children: [
                          Icon(Icons.check_box_outline_blank, color: AppColors.onSurface,),
                          SizedBox(width: 8,),
                          Text(AppStrings.accecpt1, style: TextStyle(color: AppColors.onSurface),),
                          SizedBox(width: 4,),
                          Text(AppStrings.accecpt2, style: TextStyle(color: AppColors.primary),),
                          SizedBox(width: 4,),
                          Text(AppStrings.accecpt3, style: TextStyle(color: AppColors.onSurface),),
                          SizedBox(width: 4,),
                          Text(AppStrings.accecpt4, style: TextStyle(color: AppColors.primary),),
                        ],
                      ),
                      const SizedBox(height: 35,),

                      NextButton(text: AppStrings.create, onPressed: (){}),
                      const SizedBox(height: 20,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.already_have, style: TextStyle(color: AppColors.onSurface),),
                          Text(AppStrings.login_now, style: TextStyle(color: AppColors.primary),),
                    ]
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),

      ),
    );
  }
}
