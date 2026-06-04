import 'package:flutter/material.dart';

class AppRadius {
  // Raw radius values
  static const double small = 4;
  static const double medium = 8;
  static const double mediumLarge = 12;
  static const double large = 16;
  static const double extraLarge = 24;
  static const double full = 100;

  // BorderRadius objects for direct use
  static BorderRadius get smallRadius => BorderRadius.circular(small);

  static BorderRadius get mediumRadius => BorderRadius.circular(medium);

  static BorderRadius get mediumLargeRadius =>
      BorderRadius.circular(mediumLarge);

  static BorderRadius get largeRadius => BorderRadius.circular(large);

  static BorderRadius get extraLargeRadius => BorderRadius.circular(extraLarge);

  static BorderRadius get fullRadius => BorderRadius.circular(full);

  // Radius objects for specific corners
  static Radius get smallCorner => const Radius.circular(small);

  static Radius get mediumCorner => const Radius.circular(medium);

  static Radius get mediumLargeCorner => const Radius.circular(mediumLarge);

  static Radius get largeCorner => const Radius.circular(large);

  static Radius get extraLargeCorner => const Radius.circular(extraLarge);

  static Radius get fullCorner => const Radius.circular(full);
}
