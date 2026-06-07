import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_images.dart';
import 'package:mobileapp/features/onboarding/presentation/widgets/next_button.dart';

import '../../../../core/constants/app_text.dart';
import '../widgets/social_button.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // Logo
                Row(
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

                const SizedBox(height: 40),

                 Text(
                  AppStrings.Welcome_back,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  AppStrings.sign_in,
                  style: TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 30),

                // Email
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.email,
                    style: TextStyle(fontWeight: FontWeight.w600,
                    color: AppColors.onSurface),
                  ),
                ),

                const SizedBox(height: 8),

                Text_Field(hintText: AppStrings.emailhint, hintIocn: Icons.email_outlined),

                const SizedBox(height: 20),

                // Password
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.password,
                    style: TextStyle(fontWeight: FontWeight.w600,  color: AppColors.onSurface),
                  ),
                ),

                const SizedBox(height: 8),

               Text_Field(hintText: AppStrings.passwordhint, hintIocn: Icons.lock_outline),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Checkbox(
                      value: true,
                      activeColor:  AppColors.secondary,
                      onChanged: (value) {},
                    ),
                    const Text(AppStrings.remember_me, style: TextStyle(color: AppColors.onSurface),),
                    const Spacer(),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.forgot_password,
                        style: TextStyle(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 30),

                // Sign In Button
              NextButton(text: AppStrings.login, onPressed: () {},),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade400),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(AppStrings.or, style: TextStyle(color: AppColors.gray)),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade400),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(imageUrl: AppImages.googleLogo),
                      const SizedBox(width: 40),
                    SocialButton(imageUrl: AppImages.appleLogo),
                  ],
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.dont_have_account, style: TextStyle(color: AppColors.onSurface)),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        AppStrings.sign_up,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



