import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/string_extension.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/home/presentation/bloc/categories_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeeAllCategories extends StatefulWidget {
  const SeeAllCategories({
    super.key,
  });

  static const String routeName = '/see-all-categories';

  @override
  State<SeeAllCategories> createState() => _SeeAllCategoriesState();
}

class _SeeAllCategoriesState extends State<SeeAllCategories> {
  @override
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        leading: const AppBackButton(),
        forceMaterialTransparency: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Shop by Categories',
            style: appTextTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.appText,
            ),
          ),
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
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return GestureDetector(
                        onTap: () => CategoryProductsRoute(
                          categoryId: category.id,
                          categoryName: category.name,
                        ).push(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.bgColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              if (category.image.isNotEmpty)
                                Image.network(
                                  category.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              else
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: AppColors.kBgLight2,
                                ),
                              8.horizontalSpacing,
                              AppText(
                                category.name.toTitleCase(),
                                style: appTextTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.appText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 16.horizontalSpacing,
                    itemCount: state.categories.length,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
