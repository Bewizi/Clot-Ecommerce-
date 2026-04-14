import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/variables/app_images.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.kPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.kLogo,
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
