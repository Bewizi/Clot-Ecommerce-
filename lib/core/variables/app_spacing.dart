class AppSpacing {
  static const allowed = [4, 8, 16, 24, 32, 40, 48, 56, 64];

  static double validate(double value) {
    assert(
      allowed.contains(value),

      'Spacing value $value is not in the design system: $allowed',
    );
    return value;
  }
}
