import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/app_images.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/home/presentation/pages/see_all_categories.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const String routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        centerTitle: true,
        title: AppText(
          'Order',
          style: appAltTextTheme.titleMedium?.copyWith(
            color: context.colorScheme.appText,
            fontWeight: FontWeight.w800,
          ),
        ),
        forceMaterialTransparency: true,
      ),
      body: _buildEmptyOrder(),
    );
  }

  Widget _buildEmptyOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.kCartRail,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          24.verticalSpacing,
          AppText(
            'No Orders yet',
            style: appAltTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          24.verticalSpacing,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            onPressed: () => context.push('/see-all-categories'),
            child: AppText(
              'Explore Categories',
              style: appAltTextTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
