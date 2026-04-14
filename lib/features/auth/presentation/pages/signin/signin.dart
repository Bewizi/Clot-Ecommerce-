import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/app_text_field.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            'Sign in',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    16.verticalSpacing,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppRichText(
                        textAlign: TextAlign.end,
                        spans: [
                          TextSpan(
                            text: 'Forgot password?',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.kBlack100,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  context.push(ForgotPassword.routeName),
                            text: ' Reset',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.kBlack100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                32.verticalSpacing,
                PrimaryButton(
                  pressed: () {
                    if (formKey.currentState!.validate()) {
                      // TODO: Sign in user
                    }
                  },
                  'Sign in',
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
                  text: 'Dont have an Account ?',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.kBlack100,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => CreateAccountRoute().go(context),
                  text: ' Create One',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.kBlack100,
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
