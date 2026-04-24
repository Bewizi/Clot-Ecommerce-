import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/app_text_field.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  static const String routeName = '/create-account';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }

              if (state is AccountCreated) {
                AboutYourselfRoute().go(context);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    // firstname
                    AppTextField(
                      hintText: 'Firstname',
                      controller: firstNameController,
                      prefixIcon: const Icon(Icons.person),
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
                      controller: lastNameController,
                      prefixIcon: const Icon(Icons.person),
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
                      pressed: state is AuthLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  RegisterAccount(
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                      state is AuthLoading ? 'Continue' : 'Create Account',
                      loading: state is AuthLoading,
                    ),
                  ],
                ),
              );
            },
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
