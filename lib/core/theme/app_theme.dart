import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite,
      secondary: AppColors.kBgLight2,
      onSecondary: AppColors.kBlack100,
      surface: AppColors.kWhite,
      onSurface: AppColors.kBlack100,
      error: AppColors.kDestructive50,
      onError: AppColors.kWhite,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.kTransparent),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.kWhite,
      selectedIconTheme: IconThemeData(color: AppColors.kPrimary),
      unselectedIconTheme: IconThemeData(
        color: AppColors.kBgLight2,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kMidnightViolet900,

    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite,
      secondary: AppColors.kShadowGrey800,
      onSecondary: AppColors.kWhite,
      surface: AppColors.kBlack100,
      onSurface: AppColors.kWhite,
      error: AppColors.kDestructive50,
      onError: AppColors.kWhite,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.kTransparent),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.kMidnightViolet900,
      selectedIconTheme: const IconThemeData(color: AppColors.kPrimary),
      unselectedIconTheme: IconThemeData(
        color: AppColors.kWhite.withValues(alpha: 0.5),
      ),
    ),
  );
}
