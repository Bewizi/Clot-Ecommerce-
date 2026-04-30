import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/app_text_field.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpResetPassword extends StatefulWidget {
  const OtpResetPassword({
    required this.email,
    super.key,
  });

  // email is passed from ForgotPassword so we can verify OTP against it
  final String email;

  static const String routeName = '/otp-reset-password';

  @override
  State<OtpResetPassword> createState() => _OtpResetPasswordState();
}

class _OtpResetPasswordState extends State<OtpResetPassword> {
  final otpFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        leading: const AppBackButton(),
        forceMaterialTransparency: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is PasswordUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // Navigate back to sign in
            await context.push(SignInRoute.path);
          }
        },
        builder: (context, state) {
          // After OTP verified → show new password form
          final otpVerified =
              state is OtpVerified || state is AuthLoading && _passwordPhase;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                otpVerified ? 'New Password' : 'Enter OTP',
                style: context.textTheme.headlineLarge,
              ),
              AppText(
                otpVerified
                    ? 'Create a strong new password.'
                    : 'Enter the 8-digit code sent to ${widget.email}',
                style: context.textTheme.bodyMedium,
              ),
              32.verticalSpacing,

              if (!otpVerified) ...[
                // ── Phase 1: OTP entry ──
                Form(
                  key: otpFormKey,
                  child: Column(
                    children: [
                      AppTextField(
                        hintText: 'Enter OTP',
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the OTP';
                          }
                          if (value.length != 8) {
                            return 'OTP must be 8 digits';
                          }
                          return null;
                        },
                      ),
                      32.verticalSpacing,
                      PrimaryButton(
                        state is AuthLoading ? 'Verifying...' : 'Verify OTP',
                        loading: state is AuthLoading,
                        pressed: state is AuthLoading
                            ? null
                            : () {
                                if (otpFormKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    VerifyOtp(
                                      email: widget.email,
                                      token: otpController.text.trim(),
                                    ),
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // ── Phase 2: New password entry ──
                Form(
                  key: passwordFormKey,
                  child: Column(
                    children: [
                      AppTextField(
                        hintText: 'New Password',
                        controller: newPasswordController,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: const Icon(Icons.visibility_outlined),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      AppTextField(
                        hintText: 'Confirm Password',
                        controller: confirmPasswordController,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: const Icon(Icons.visibility_outlined),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      32.verticalSpacing,
                      PrimaryButton(
                        state is AuthLoading
                            ? 'Updating...'
                            : 'Update Password',
                        loading: state is AuthLoading,
                        pressed: state is AuthLoading
                            ? null
                            : () {
                                if (passwordFormKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    UpdatePassword(
                                      newPassword: newPasswordController.text
                                          .trim(),
                                    ),
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  // tracks whether we've moved to phase 2 so loading state renders correctly
  bool get _passwordPhase =>
      newPasswordController.text.isNotEmpty ||
      confirmPasswordController.text.isNotEmpty;
}
