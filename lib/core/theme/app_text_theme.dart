import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clot/core/variables/colors.dart';

TextTheme appTextTheme = GoogleFonts.dmSansTextTheme(
  const TextTheme(
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
