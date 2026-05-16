import 'package:clot/core/theme/app_text_theme.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
      body: const Column(),
    );
  }
}
