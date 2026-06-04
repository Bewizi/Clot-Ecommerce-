import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Center(
            child: AppText(
              'Profile Page',
              style: context.textTheme.headlineLarge,
            ),
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const CircularProgressIndicator();
              } else if (state is ProfileLoaded) {
                return Column(
                  children: [
                    AppText(
                      'Full Name: ${state.profile.firstname} ${state.profile.lastname}',
                    ),
                    AppText('Email: ${state.profile.email}'),
                  ],
                );
              } else if (state is ProfileError) {
                return AppText('Error: ${state.message}');
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
