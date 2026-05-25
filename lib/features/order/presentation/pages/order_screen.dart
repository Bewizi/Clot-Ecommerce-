import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/app_images.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/order/domain/orders_domain.dart';
import 'package:clot/features/order/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const String routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _selectedStatus = 'Processing';

  final List<String> _tabs = [
    'Processing',
    'Shipped',
    'Delivered',
    'Returned',
    'Canceled',
  ];

  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(
      const FetchOrdersByUserEvent(status: 'Processing'),
    );
  }

  void _onTabSelected(String status) {
    if (_selectedStatus == status) return;
    setState(() => _selectedStatus = status);
    context.read<OrdersBloc>().add(FetchOrdersByUserEvent(status: status));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        centerTitle: true,
        title: AppText(
          'Orders',
          style: appAltTextTheme.titleMedium?.copyWith(
            color: context.colorScheme.appText,
            fontWeight: FontWeight.w800,
          ),
        ),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          16.verticalSpacing,
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _tabs.map((tab) {
          final isSelected = tab == _selectedStatus;
          return GestureDetector(
            onTap: () => _onTabSelected(tab),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.kPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected
                      ? AppColors.kPrimary
                      : context.colorScheme.appText.withValues(alpha: 0.2),
                ),
              ),
              child: AppText(
                tab,
                style: appAltTextTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : context.colorScheme.appText.withValues(alpha: 0.6),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.kPrimary),
          );
        }

        if (state is OrdersError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: context.colorScheme.appText.withValues(alpha: 0.4),
                ),
                16.verticalSpacing,
                AppText(
                  'Something went wrong',
                  style: appAltTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                8.verticalSpacing,
                AppText(
                  state.message,
                  style: appAltTextTheme.bodySmall?.copyWith(
                    color: context.colorScheme.appText.withValues(alpha: 0.5),
                  ),
                ),
                24.verticalSpacing,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => context.read<OrdersBloc>().add(
                    FetchOrdersByUserEvent(status: _selectedStatus),
                  ),
                  child: AppText(
                    'Try Again',
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

        if (state is OrdersLoaded) {
          if (state.orders.isEmpty) return _buildEmptyOrder();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.orders.length,
            separatorBuilder: (_, __) => 12.verticalSpacing,
            itemBuilder: (context, index) {
              return _buildOrderCard(state.orders[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildOrderCard(OrdersDomain order) {
    return GestureDetector(
      onTap: () => context.push('/order-details/${order.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: context.colorScheme.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon
            SvgPicture.asset(
              AppSvg.kReceipt,
              colorFilter: ColorFilter.mode(
                context.colorScheme.appText,
                BlendMode.srcIn,
              ),
            ),

            16.horizontalSpacing,

            // Order info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Order  #${order.orderNumber}',
                    style: appAltTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.appText,
                    ),
                  ),
                  8.verticalSpacing,
                  AppText(
                    '${_itemCountLabel(order)} · ${DateFormat('d MMM').format(order.placedAt)}',
                    style: appAltTextTheme.bodySmall?.copyWith(
                      color: context.colorScheme.appText.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            SvgPicture.asset(
              AppSvg.kArrowRight,
              colorFilter: ColorFilter.mode(
                context.colorScheme.appText,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Placeholder until items count is embedded in the order
  String _itemCountLabel(OrdersDomain order) {
    return 'View items';
  }

  Widget _buildEmptyOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.kCartRail,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          24.verticalSpacing,
          AppText(
            'No Orders yet',
            style: appAltTextTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          24.verticalSpacing,
          PrimaryButton(
            pressed: () => context.push('/see-all-categories'),
            'Explore Categories',
            width: MediaQuery.sizeOf(context).width * 0.6,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          ),
        ],
      ),
    );
  }
}
