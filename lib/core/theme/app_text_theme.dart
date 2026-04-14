import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme appTextTheme = GoogleFonts.nunitoSansTextTheme(
  const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppColors.kBlack100,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppColors.kWhite,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: AppColors.kWhite,
    ),

    titleMedium: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppColors.kWhite,
    ),

    titleSmall: TextStyle(
      fontWeight: FontWeight.w700,
    ),

    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
    ),
  ),
);
