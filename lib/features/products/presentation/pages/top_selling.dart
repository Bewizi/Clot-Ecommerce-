import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/app_radius.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/products/bloc/top_selling/bloc/top_selling_bloc.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TopSelling extends StatefulWidget {
  const TopSelling({super.key});

  @override
  State<TopSelling> createState() => _TopSellingState();
}

class _TopSellingState extends State<TopSelling> {
  @override
  void initState() {
    super.initState();
    context.read<TopSellingBloc>().add(const FetchTopSelling());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row — separate from BlocBuilder
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              'Top Selling',
              style: appAltTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.appText,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(''), // wire up your route
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
        12.verticalSpacing,
        // Product list — below the header
        BlocBuilder<TopSellingBloc, TopSellingState>(
          builder: (context, state) {
            if (state is TopSellingLoading) {
              return const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is TopSellingFailure) {
              return SizedBox(
                height: 60,
                child: Center(child: AppText(state.errorMessage)),
              );
            }

            if (state is TopSellingLoaded) {
              if (state.products.isEmpty) {
                return const SizedBox(
                  height: 60,
                  child: Center(child: AppText('No top selling products.')),
                );
              }

              return SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products.length,
                  separatorBuilder: (_, _) => 16.horizontalSpacing,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return GestureDetector(
                      onTap: () => ProductsRoute(
                        productId: product.productId,
                      ).push(context),
                      child: _ProductCard(product: product),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductsDomain product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
                top: Radius.circular(AppRadius.medium),
              ),
              child: Stack(
                children: [
                  Image.network(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                        ? child
                        : Container(color: AppColors.kBgLight2),
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: AppColors.kBgLight2),
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
                    color: Theme.of(context).colorScheme.appText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpacing,
                AppText(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: appTextTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.appText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
