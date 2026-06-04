import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    color: context.colorScheme.brightness == Brightness.dark
                        ? AppColors.kWhite.withValues(alpha: 0.5)
                        : AppColors.kBlack100.withValues(alpha: 0.5),
                  ),
                ),
                4.verticalSpacing,
                AppText(
                  '121-224-7890',
                  style: context.textTheme.titleMedium!.copyWith(
                    color: context.colorScheme.brightness == Brightness.dark
                        ? AppColors.kWhite.withValues(alpha: 0.5)
                        : AppColors.kBlack100.withValues(alpha: 0.5),
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
}
