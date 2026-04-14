import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.kBgLight2,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.kBlack100,
            ),
          ),
        ),
      ),
    );
  }
}
