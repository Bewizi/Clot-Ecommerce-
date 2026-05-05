import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextTheme _baseTextTheme = TextTheme(
  headlineLarge: TextStyle(
    fontWeight: FontWeight.w800,
  ),
  displaySmall: TextStyle(
    fontWeight: FontWeight.w800,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w800,
  ),
  titleSmall: TextStyle(
    fontWeight: FontWeight.w700,
  ),
  bodySmall: TextStyle(
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
