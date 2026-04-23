import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

extension AppColorScheme on ColorScheme {
  Color get hintText => brightness == Brightness.dark
      ? AppColors.kWhite.withValues(alpha: 0.5)
      : AppColors.kBlack100.withValues(alpha: 0.5);

  Color get appText => brightness == Brightness.dark
      ? AppColors.kWhite
      : AppColors.kMidnightViolet900;

  Color get bgColor => brightness == Brightness.dark
      ? AppColors.kShadowGrey800
      : AppColors.kBgLight2;
}
