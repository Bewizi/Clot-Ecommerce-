import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/string_extension.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/products/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  final String categoryId;
  final String categoryName;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  int productNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(
      GetProducts(categoryId: widget.categoryId),
    );
  }

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
          BlocListener<ProductsBloc, ProductsState>(
            listener: (context, state) {
              if (state is ProductsLoaded) {
                setState(() {
                  productNumber = state.products.length;
                });
              }
            },
            child: AppText(
              '${widget.categoryName.toTitleCase()} ($productNumber)',
              style: appTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.appText,
              ),
            ),
          ),
          16.verticalSpacing,
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductsError) {
                return Center(child: AppText(state.message));
              }

              if (state is ProductsLoaded) {
                if (state.products.isEmpty) {
                  return const Center(child: AppText('No products found.'));
                }

                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.bgColor,
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      product.image,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      loadingBuilder:
                                          (context, child, loadingProgress) =>
                                              loadingProgress == null
                                              ? child
                                              : Container(
                                                  color: AppColors.kBgLight2,
                                                ),

                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: AppColors.kBgLight2,
                                              ),
                                    ),
                                    Positioned(
                                      top: 9,
                                      right: 8,

                                      child: SvgPicture.asset(
                                        AppSvg.kHeart,
                                        fit: BoxFit.cover,
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    product.title,
                                    style: appTextTheme.bodySmall?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.appText,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  AppText(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: appTextTheme.bodySmall?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.appText,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
