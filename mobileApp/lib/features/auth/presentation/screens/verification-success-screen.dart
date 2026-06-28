import 'package:flutter/material.dart';
import 'package:mobileapp/features/auth/presentation/screens/login_screen.dart';
import 'package:mobileapp/features/onboarding/presentation/widgets/next_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/success_animation.dart';

class AccountCreatingSuccessScreen extends StatefulWidget {
  const AccountCreatingSuccessScreen({super.key});

  @override
  State<AccountCreatingSuccessScreen> createState() =>
      _AccountCreatingSuccessScreenState();
}

class _AccountCreatingSuccessScreenState
    extends State<AccountCreatingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150,),
            const SuccessAnimation(),
            const SizedBox(height: 80,),
            // text tile
            const Text("Congratulation !", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.onSurface),),
            const Text("Your account has deen created Successfully", style: TextStyle(fontSize: 16, color: AppColors.gray),),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: NextButton(text: "Continue", onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}