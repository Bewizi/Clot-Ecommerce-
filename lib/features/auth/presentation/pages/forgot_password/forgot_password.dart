import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/app_text_field.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const String routeName = '/forgot-password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

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
            'Forgot Password',
            style: context.textTheme.headlineLarge,
          ),
          32.verticalSpacing,
          Form(
            key: formKey,
            child: Column(
              children: [
                AppTextField(
                  hintText: 'Email Address',
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                32.verticalSpacing,
                PrimaryButton(
                  pressed: () {
                    if (formKey.currentState!.validate()) {
                      // TODO: Sign in user
                    }
                  },
                  'Continue',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
