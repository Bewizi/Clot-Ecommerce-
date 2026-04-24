import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/app_images.dart';
import 'package:flutter/material.dart';

mixin RedirectToLogin {
  Future<void> showRedirectToLoginDialog(BuildContext context) async {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final titleStyle = context.textTheme.titleMedium!.copyWith(
      color: Theme.of(context).colorScheme.appText,
    );
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.bgColor,

      builder: (sheetContext) {
        return SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.kEMailBox,
                  width: 120,
                  height: 120,
                ),
                24.verticalSpacing,
                AppText(
                  'We Sent you an Email to reset your password.',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                24.verticalSpacing,
                PrimaryButton(
                  pressed: () {
                    SignInRoute().go(context);
                  },
                  'Return to Login',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
