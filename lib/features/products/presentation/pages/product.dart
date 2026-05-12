import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:clot/features/products/bloc/products_bloc.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Product extends StatefulWidget {
  const Product({required this.productId, super.key});

  final String productId;

  static const String routeName = '/products';

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(
      GetProductsById(productId: widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoaded) {
                final product = state.products;
                return _buildAddToCart(product[0]);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      appbar: AppBar(
        leading: const AppBackButton(),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsError) {
              return Center(child: Text(state.message));
            }
            if (state is ProductsLoaded) {
              final product = state.products;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.network(
                      product[0].image,
                    ),
                  ),
                  8.verticalSpacing,
                  AppText(
                    product[0].title,
                    style: appAltTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  4.verticalSpacing,
                  AppText(
                    '\$${product[0].price}',
                    style: appAltTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.kPrimary,
                    ),
                  ),
                  24.verticalSpacing,
                  _buildQuantity(),
                  16.verticalSpacing,
                  AppText(product[0].description),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildQuantity() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            'Quantity',
            style: appTextTheme.bodyLarge,
          ),
          Row(
            children: [
              _buildSign('+'),
              16.horizontalSpacing,
              AppText(
                '1',
                style: appTextTheme.bodyLarge,
              ),
              16.horizontalSpacing,
              _buildSign('-'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSign(String sign) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kPrimary,
      ),
      child: Center(
        child: AppText(
          sign,
          style: appAltTextTheme.titleMedium?.copyWith(color: AppColors.kWhite),
        ),
      ),
    );
  }

  Widget _buildAddToCart(ProductsDomain product) {
    return GestureDetector(
      onTap: () {
        final userId = supaBase.auth.currentUser?.id ?? '';
        context.read<CartBloc>().add(
          AddToCart(
            productId: product.productId,
            userId: userId,
            title: product.title,
            price: product.price,
            image: product.image,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.kPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              '\$${product.price}',
              style: appAltTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.kWhite,
              ),
            ),

            AppText(
              'Add to Bag',
              style: appTextTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
