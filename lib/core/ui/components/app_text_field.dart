import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.controller,
    this.hintText,
    this.showTitle = true,
    this.title,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconConstraints,
    this.onSuffixIconTap,
    this.onChanged,
    super.key,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool showTitle;
  final String? title;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final VoidCallback? onSuffixIconTap;
  final void Function(String)? onChanged;

  Widget _buildTextFormField(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(
            color: AppColors.kBlack100.withValues(alpha: 05),
          ),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        hintStyle:
            Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(
              color: AppColors.kBgLight2,
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixIconTap,
                child: suffixIcon,
              )
            : null,
        // prefixIconColor: AppColors.kGrey30,
        // suffixIconColor: AppColors.kGrey30,
        prefixIconConstraints: prefixIconConstraints,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle && title != null) ...[
          AppText(
            title!,
            style:
                Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(
                  color: AppColors.kBgLight2,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
        8.verticalSpacing,
        _buildTextFormField(context),
      ],
    );
  }
}
