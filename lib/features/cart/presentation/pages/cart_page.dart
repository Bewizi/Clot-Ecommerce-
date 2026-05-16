import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/app_images.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/cart/domain/cart_domain.dart';
import 'package:clot/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
    context.read<CartBloc>().add(LoadCartItem(userId: userId));
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        leading: const AppBackButton(),
        title: AppText(
          'Cart',
          style: appAltTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cartItems.isNotEmpty) {
                return TextButton(
                  onPressed: () {
                    final userId =
                        Supabase.instance.client.auth.currentUser?.id ?? '';
                    context.read<CartBloc>().add(
                      RemoveAllFromCart(userId: userId),
                    );
                  },
                  child: AppText(
                    'Remove All',
                    style: appTextTheme.bodyMedium?.copyWith(
                      color: AppColors.kPrimary,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(child: AppText(state.message));
          }
          if (state is CartLoaded) {
            if (state.cartItems.isEmpty) return _buildEmptyCart();
            return _buildCartContent(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.kCartBag,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          24.verticalSpacing,
          AppText(
            'Your Cart is Empty',
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
            onPressed: () => Navigator.pop(context),
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

  Widget _buildCartContent(CartLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: state.cartItems.length,
            separatorBuilder: (_, _) => 12.verticalSpacing,
            itemBuilder: (context, index) =>
                _buildCartItem(state.cartItems[index]),
          ),
        ),
        _buildSummary(state),
      ],
    );
  }

  Widget _buildCartItem(CartDomain item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.image,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 72,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          12.horizontalSpacing,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  item.title,
                  style: appAltTextTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpacing,
                AppText(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: appAltTextTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.kPrimary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => context.read<CartBloc>().add(
                  RemoveFromCart(cartItemId: item.cartId),
                ),
                child: const Icon(Icons.close, size: 18, color: Colors.grey),
              ),
              8.verticalSpacing,
              _buildQuantityControls(item),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(CartDomain item) {
    return Row(
      children: [
        _buildQtyBtn(
          icon: Icons.remove,
          onTap: () {
            if (item.quantity <= 1) {
              context.read<CartBloc>().add(
                RemoveFromCart(cartItemId: item.cartId),
              );
            } else {
              context.read<CartBloc>().add(
                UpdateQuantity(
                  cartItemId: item.cartId,
                  newQuantity: item.quantity - 1,
                ),
              );
            }
          },
        ),
        12.horizontalSpacing,
        AppText(
          '${item.quantity}',
          style: appAltTextTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        12.horizontalSpacing,
        _buildQtyBtn(
          icon: Icons.add,
          onTap: () => context.read<CartBloc>().add(
            UpdateQuantity(
              cartItemId: item.cartId,
              newQuantity: item.quantity + 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.kPrimary,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildSummary(CartLoaded state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow(
            'Subtotal',
            '\$${state.subtotal.toStringAsFixed(2)}',
          ),
          8.verticalSpacing,
          _buildSummaryRow(
            'Shipping Cost',
            '\$${state.shippingCost.toStringAsFixed(2)}',
          ),
          8.verticalSpacing,
          _buildSummaryRow('Tax', '\$${state.tax.toStringAsFixed(2)}'),
          const Divider(height: 20),
          _buildSummaryRow(
            'Total',
            '\$${state.total.toStringAsFixed(2)}',
            bold: true,
          ),
          16.verticalSpacing,
          // Coupon field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.bgColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.discount_outlined,
                  color: AppColors.kPrimary,
                  size: 20,
                ),
                8.horizontalSpacing,
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Coupon Code',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimary,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpacing,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () async {
                await context.push('/checkout');
              },
              child: AppText(
                'Checkout',
                style: appAltTextTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          style: bold
              ? appAltTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800)
              : appTextTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        AppText(
          value,
          style: bold
              ? appAltTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800)
              : appTextTheme.bodyMedium,
        ),
      ],
    );
  }
}
