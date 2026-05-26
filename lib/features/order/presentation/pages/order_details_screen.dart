import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/order/domain/order_item_domain.dart';
import 'package:clot/features/order/domain/orders_domain.dart';
import 'package:clot/features/order/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(
      FetchOrderItemsEvent(orderId: widget.orderId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        final orderNumber = switch (state) {
          final OrderItemsLoaded s => s.order.orderNumber,
          final OrderDetailLoaded s => s.order.orderNumber,
          _ => '...',
        };

        return AppScaffold(
          appbar: AppBar(
            leading: const AppBackButton(),
            centerTitle: true,
            forceMaterialTransparency: true,
            title: AppText(
              'Order  #$orderNumber',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.appText,
              ),
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(OrdersState state) {
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
              color: Theme.of(
                context,
              ).colorScheme.appText.withValues(alpha: 0.4),
            ),
            16.verticalSpacing,
            AppText(
              'Failed to load order details.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            16.verticalSpacing,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () => context.read<OrdersBloc>().add(
                FetchOrderItemsEvent(orderId: widget.orderId),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    if (state is OrderItemsLoaded) {
      return _buildContent(state.order, state.items);
    }

    return const SizedBox.shrink();
  }

  Widget _buildContent(OrdersDomain order, List<OrderItemDomain> items) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Status Timeline ──────────────────────────────────
          _buildTimeline(order),
          24.verticalSpacing,

          // ── Order Items ──────────────────────────────────────
          _buildSectionTitle('Order Items'),
          12.verticalSpacing,
          _buildOrderItemsCard(items),
          24.verticalSpacing,

          // ── Shipping Details ─────────────────────────────────
          _buildSectionTitle('Shipping details'),
          12.verticalSpacing,
          _buildShippingCard(order),
        ],
      ),
    );
  }

  // ── Timeline ───────────────────────────────────────────────────────────────

  Widget _buildTimeline(OrdersDomain order) {
    // Build steps based on what timestamps are available.
    // Always show from bottom (Order Placed) to top (latest status).
    final steps = _buildSteps(order);

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == steps.length - 1;
        return _buildTimelineRow(
          label: step.label,
          date: step.date,
          isCompleted: step.isCompleted,
          isLast: isLast,
        );
      }).toList(),
    );
  }

  List<_TimelineStep> _buildSteps(OrdersDomain order) {
    // Order from top (most recent possible) to bottom (oldest)
    final fmt = DateFormat('d MMM');
    return [
      if (order.canceledAt != null)
        _TimelineStep(
          label: 'Canceled',
          date: fmt.format(order.canceledAt!),
          isCompleted: true,
        ),
      if (order.returnedAt != null)
        _TimelineStep(
          label: 'Returned',
          date: fmt.format(order.returnedAt!),
          isCompleted: true,
        ),
      _TimelineStep(
        label: 'Delivered',
        date: order.deliveredAt != null ? fmt.format(order.deliveredAt!) : '',
        isCompleted: order.deliveredAt != null,
      ),
      _TimelineStep(
        label: 'Shipped',
        date: order.shippedAt != null ? fmt.format(order.shippedAt!) : '',
        isCompleted: order.shippedAt != null,
      ),
      _TimelineStep(
        label: 'Order Confirmed',
        date: order.confirmedAt != null ? fmt.format(order.confirmedAt!) : '',
        isCompleted: order.confirmedAt != null,
      ),
      _TimelineStep(
        label: 'Order Placed',
        date: fmt.format(order.placedAt),
        isCompleted: true,
      ),
    ];
  }

  Widget _buildTimelineRow({
    required String label,
    required String date,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: icon + vertical line
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? AppColors.kPrimary : Colors.transparent,
                  border: Border.all(
                    color: isCompleted
                        ? AppColors.kPrimary
                        : Theme.of(
                            context,
                          ).colorScheme.appText.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: Theme.of(
                    context,
                  ).colorScheme.appText.withValues(alpha: 0.15),
                ),
            ],
          ),
        ),
        16.horizontalSpacing,

        // Right: label + date
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  label,
                  style: appAltTextTheme.bodyMedium?.copyWith(
                    fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w400,
                    color: isCompleted
                        ? Theme.of(context).colorScheme.appText
                        : Theme.of(
                            context,
                          ).colorScheme.appText.withValues(alpha: 0.4),
                  ),
                ),
                if (date.isNotEmpty)
                  AppText(
                    date,
                    style: appAltTextTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.appText.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Order Items Card ───────────────────────────────────────────────────────

  Widget _buildOrderItemsCard(List<OrderItemDomain> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppSvg.kReceipt,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.appText,
              BlendMode.srcIn,
            ),
          ),
          12.horizontalSpacing,
          AppText(
            '${items.length} ${items.length == 1 ? 'item' : 'items'}',
            style: appAltTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              CartPageRoute().go(context);
            },
            child: AppText(
              'View All',
              style: appAltTextTheme.bodySmall?.copyWith(
                color: AppColors.kPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Shipping Card ──────────────────────────────────────────────────────────

  Widget _buildShippingCard(OrdersDomain order) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            order.shippingAddress,
            style: appAltTextTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.appText,
            ),
          ),
          if (order.shippingPhone != null) ...[
            8.verticalSpacing,
            AppText(
              order.shippingPhone!,
              style: appAltTextTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.appText.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppText(
      title,
      style: appAltTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.appText,
      ),
    );
  }
}

// ── Helper model ───────────────────────────────────────────────────────────

class _TimelineStep {
  const _TimelineStep({
    required this.label,
    required this.date,
    required this.isCompleted,
  });

  final String label;
  final String date;
  final bool isCompleted;
}
