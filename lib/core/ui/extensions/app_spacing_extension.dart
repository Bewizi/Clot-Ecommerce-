import 'package:flutter/material.dart';
import 'package:clot/core/variables/app_spacing.dart';

extension AppSpacingExtension on num {
  SizedBox get verticalSpacing =>
      SizedBox(height: AppSpacing.validate(toDouble()));

  SizedBox get horizontalSpacing =>
      SizedBox(width: AppSpacing.validate(toDouble()));
}
