import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/variables/app_iconsize.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.text, {
    this.disabled = true,
    this.loading = false,
    this.pressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    super.key,
  });

  final bool disabled;
  final bool loading;
  final VoidCallback? pressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
        decoration: BoxDecoration(
          color: color ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: AppText(
          text,
          style:
              Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(
                color: textColor ?? AppColors.kWhite,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  const OutlineButton(
    this.text, {
    this.disabled = true,
    this.loading = false,
    this.pressed,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  });

  final bool disabled;
  final bool loading;
  final VoidCallback? pressed;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.kBlack100,
          borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.lager),
          border: Border.all(color: borderColor ?? AppColors.kPrimary),
        ),
        child: Center(
          child: AppText(
            text,
            style:
                Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(
                  color: textColor ?? AppColors.kWhite,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// IconButton
class IconConButton extends StatelessWidget {
  const IconConButton({
    required this.child,
    this.disabled = true,
    this.loading = false,
    this.pressed,
    this.bgColor,
    this.borderColor,
    this.shape,
    this.borderRadius,
    super.key,
  });

  final bool disabled;
  final bool loading;
  final VoidCallback? pressed;
  final Widget child;
  final Color? bgColor;
  final Color? borderColor;
  final BoxShape? shape;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: AppIconContainerSize.medium,
        height: AppIconContainerSize.medium,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.kBlack100,
          border: Border.all(color: borderColor ?? AppColors.kPrimary),
          shape: shape ?? BoxShape.rectangle,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius ?? AppRadius.lager),
        ),
        child: child,
      ),
    );
  }
}

// GhostButton
//

// LoadingButton
