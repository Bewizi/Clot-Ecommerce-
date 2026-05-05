import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:clot/features/home/presentation/widgets/homedelegate_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final user = supaBase.auth.currentUser;
    if (user != null) {
      context.read<AuthBloc>().add(GetUserData(userId: user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HomeHeaderDelegate(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.kPrimary,
                  ),

                  _buildGenderSelector(),

                  _buildCart(),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Your Search Bar and Categories go here
                  AppText('Products and Categories go here...'),
                  // Add enough height to test the scroll
                  SizedBox(height: 1000),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              color: AppColors.kBgLight2,
              borderRadius: BorderRadius.circular(AppRadius.fullRadius),
            ),
            child: const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        var label = 'Unknown';
        if (state is GetUserInfo) {
          final gender = state.authDomain.gender?.trim().toUpperCase();
          if (gender != null && gender.isNotEmpty) {
            label = gender[0].toUpperCase() + gender.substring(1).toLowerCase();
          }
        }

        return Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.kBgLight2,
            borderRadius: BorderRadius.circular(AppRadius.fullRadius),
          ),
          child: Center(
            child: AppText(
              label,
              style: appAltTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.kBlack100,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCart() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: BorderRadius.circular(AppRadius.fullRadius),
      ),
      child: Center(child: SvgPicture.asset(AppSvg.kBag)),
    );
  }
}
