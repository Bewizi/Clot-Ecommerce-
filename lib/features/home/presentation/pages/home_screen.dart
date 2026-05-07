import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/string_extension.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:clot/features/home/presentation/bloc/categories_bloc.dart';
import 'package:clot/features/home/presentation/widgets/homedelegate_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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

    context.read<CategoriesBloc>().add(const GetCategories());
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        'Categories',
                        style: appAltTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.appText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push(SeeAllCategoriesRoute.path),
                        child: AppText(
                          'See All',
                          style: appTextTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.appText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Your Search Bar and Categories go here
                  16.verticalSpacing,
                  BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is CategoriesError) {
                        return SizedBox(
                          height: 100,
                          child: Center(child: AppText(state.message)),
                        );
                      }

                      if (state is CategoriesLoaded) {
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final category = state.categories[index];
                              return Column(
                                children: [
                                  if (category.image.isNotEmpty)
                                    Image.network(
                                      category.image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Container(
                                      width: 80,
                                      height: 80,
                                      color: AppColors.kBgLight2,
                                    ),
                                  8.verticalSpacing,
                                  AppText(
                                    category.name.toTitleCase(),
                                    style: appTextTheme.bodySmall,
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                16.horizontalSpacing,
                            itemCount: state.categories.length,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // Add enough height to test the scroll
                  const SizedBox(height: 1000),
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
