import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/app_text_field.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:clot/features/order/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is PlaceOrderSuccess) {
          OrderSuccessfulPageRoute().go(context);
        }

        if (state is OrdersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      child: AppScaffold(
        appbar: AppBar(
          title: AppText(
            'Checkout',
            style: appAltTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.appText,
            ),
          ),
          centerTitle: true,
          forceMaterialTransparency: true,
          leading: const AppBackButton(),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Shipping Address
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppTextField(
                      title: 'Shipping Address',
                      verticalSpacing: 0,
                      controller: _addressController,
                      inputDecoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Add Shipping Address',
                        hintStyle: TextStyle(
                          fontSize: appTextTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).colorScheme.appText,
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpacing,
                  // Payment Method
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppTextField(
                      title: 'Payment Method',
                      controller: _phoneController,
                      verticalSpacing: 0,
                      keyboardType: TextInputType.phone,
                      inputDecoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Add Payment Method',

                        hintStyle: TextStyle(
                          fontSize: appTextTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).colorScheme.appText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildPlaceOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final totalAmount = state.total;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
            onPressed: () {
              context.read<OrdersBloc>().add(
                PlaceOrderEvent(
                  shippingAddress: _addressController.text.trim(),
                  shippingPhone: _phoneController.text.trim(),
                  cartItems: state.cartItems,
                  total: state.total,
                ),
              );
            },
            child: Row(
              children: [
                AppText(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: appTextTheme.titleMedium?.copyWith(
                    color: AppColors.kWhite,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),

                AppText(
                  'Place Order',
                  style: appTextTheme.titleMedium?.copyWith(
                    color: AppColors.kWhite,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
