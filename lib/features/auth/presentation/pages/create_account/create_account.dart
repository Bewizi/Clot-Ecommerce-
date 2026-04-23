import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/app_text_field.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  static const String routeName = '/create-account';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Create Account',
            style: context.textTheme.headlineLarge,
          ),
          32.verticalSpacing,
          Form(
            key: formKey,
            child: Column(
              children: [
                // firstname
                AppTextField(
                  hintText: 'Firstname',
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your firstname';
                    }

                    return null;
                  },
                ),

                // lastname
                AppTextField(
                  hintText: 'Lastname',
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your lastname';
                    }
                    return null;
                  },
                ),

                //email
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

                // password
                AppTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: const Icon(Icons.visibility_outlined),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
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
                    AboutYourselfRoute().go(context);
                  },
                  'Continue',
                ),
              ],
            ),
          ),
          16.verticalSpacing,
          Align(
            alignment: Alignment.bottomLeft,
            child: AppRichText(
              spans: [
                TextSpan(
                  text: 'Have an Account ?',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.appText,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => SignInRoute().go(context),
                  text: ' Sing In',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.appText,
                    fontWeight: FontWeight.bold,
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
