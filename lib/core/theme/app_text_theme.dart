import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextTheme _baseTextTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
);

final TextTheme appTextTheme = GoogleFonts.nunitoSansTextTheme(_baseTextTheme);

final TextTheme appAltTextTheme = GoogleFonts.gabaritoTextTheme(_baseTextTheme);

/// Use this when you want the app's default text theme,
/// but need a single style in the alternate font.
TextStyle appAltFontStyle(TextStyle style) {
  return GoogleFonts.gabarito(textStyle: style);
}
