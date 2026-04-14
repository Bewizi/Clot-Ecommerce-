import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite,

      secondary: AppColors.kBgLight2,
      onSecondary: AppColors.kBlack100,

      error: AppColors.kDestructive50,
      onError: AppColors.kBgLight2,

      surface: AppColors.kWhite,
      onSurface: AppColors.kBgLight2,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.kTransparent),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kBlack100,
    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite,

      secondary: AppColors.kBgLight2,
      onSecondary: AppColors.kBlack100,

      error: AppColors.kDestructive50,
      onError: AppColors.kBgLight2,

      surface: AppColors.kWhite,
      onSurface: AppColors.kBgLight2,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.kTransparent),
      ),
    ),
  );
}
