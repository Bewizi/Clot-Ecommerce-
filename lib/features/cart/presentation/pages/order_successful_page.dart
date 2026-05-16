import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/app_images.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatelessWidget {
  const OrderSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomNavigationBar: _buildOrderPlacedSuccessfully(context),
      backgroundColor: AppColors.kPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              child: Image.asset(
                AppImages.kOrderSuccessImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderPlacedSuccessfully(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      height: MediaQuery.sizeOf(context).height * 0.35,
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppText(
              'Order Placed Successfully',
              style: appAltTextTheme.headlineLarge?.copyWith(
                color: AppColors.kBlack100,
                fontWeight: FontWeight.w800,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            16.verticalSpacing,
            AppText(
              'You will recieve an email confirmation',
              style: appTextTheme.bodyLarge?.copyWith(
                color: AppColors.kBlack100.withValues(alpha: 0.5),
              ),
            ),
            40.verticalSpacing,
            PrimaryButton(
              'See Order details',
              pressed: () {
                OrderPageRoute().go(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
