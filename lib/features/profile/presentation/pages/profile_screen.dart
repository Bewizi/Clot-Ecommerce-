import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AppText(
              'Profile Page',
              style: context.textTheme.headlineLarge,
            ),
          ),
          _buildProfileInfo(),
          24.verticalSpacing,
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildProfileOption('Address', () {
                // Navigate to Edit Profile screen
              }),
              8.verticalSpacing,
              _buildProfileOption('Wishlist', () {
                // Navigate to Settings screen
              }),
              8.verticalSpacing,
              _buildProfileOption('Payment', () {
                // Handle logout
              }),
              8.verticalSpacing,
              _buildProfileOption('Help', () {
                // Handle logout
              }),
              8.verticalSpacing,
              _buildProfileOption('Support', () {
                // Handle logout
              }),
            ],
          ),
          32.verticalSpacing,

          Center(
            child: GestureDetector(
              onTap: () async {
                await supaBase.auth.signOut();
                if (context.mounted) SignInRoute().go(context);
              },
              child: AppText(
                'Sign Out',
                style: appAltTextTheme.titleMedium!.copyWith(
                  color: AppColors.kDestructive60,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProfileLoaded) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: context.colorScheme.bgColor,
              borderRadius: AppRadius.mediumRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  ' ${state.profile.firstname} ${state.profile.lastname}',
                  style: appAltTextTheme.titleMedium!.copyWith(
                    color: context.colorScheme.appText,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                8.verticalSpacing,
                AppText(
                  ' ${state.profile.email}',
                  style: context.textTheme.titleMedium!.copyWith(
                    color: context.colorScheme.hintText,
                  ),
                ),
                4.verticalSpacing,
                AppText(
                  '121-224-7890',
                  style: context.textTheme.titleMedium!.copyWith(
                    color: context.colorScheme.hintText,
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return AppText('Error: ${state.message}');
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildProfileOption(String title, VoidCallback onTap) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.bgColor,
        borderRadius: AppRadius.mediumRadius,
      ),
      child: ListTile(
        onTap: onTap,
        title: AppText(
          title,
          style: appTextTheme.titleMedium!.copyWith(
            color: context.colorScheme.appText,
          ),
        ),
        trailing: SvgPicture.asset(
          AppSvg.kArrowRight,
          colorFilter: ColorFilter.mode(
            context.colorScheme.appText,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
