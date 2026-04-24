import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AboutYourself extends StatefulWidget {
  const AboutYourself({super.key});

  static const String routeName = '/about-yourself';

  @override
  State<AboutYourself> createState() => _AboutYourselfState();
}

class _AboutYourselfState extends State<AboutYourself> {
  String? selectedGender = 'Men';
  String? selectedAge;

  final List<String> ages = List.generate(121, (index) => index.toString());

  String _toDbGender(String label) {
    return label == 'Men' ? 'male' : 'female';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile Updated Successfully')),
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Tell us About yourself',
                        style: context.textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.appText,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      48.verticalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'Who do you shop for ?',
                            style: context.textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.appText,
                            ),
                          ),
                          24.verticalSpacing,
                          Row(
                            children: [
                              _buildGenderButton('Men'),
                              24.horizontalSpacing,
                              _buildGenderButton('Women'),
                            ],
                          ),
                        ],
                      ),
                      48.verticalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'How Old are you ?',
                            style: context.textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.appText,
                            ),
                          ),
                          24.verticalSpacing,
                          _buildAgeDropdown(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                'Finish',
                color: AppColors.kPrimary,
                textColor: AppColors.kWhite,
                pressed:
                    (selectedGender != null &&
                        selectedAge != null &&
                        state is! AuthLoading)
                    ? () {
                        final userId = supabase
                            .Supabase
                            .instance
                            .client
                            .auth
                            .currentUser
                            ?.id;

                        context.read<AuthBloc>().add(
                          UpdateProfile(
                            age: int.parse(selectedAge!),
                            gender: _toDbGender(selectedGender!),
                            userId: userId!,
                          ),
                        );
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAgeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedAge,
          hint: AppText(
            'Age Range',
            style: context.textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.appText,
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.appText,
          ),
          items: ages.map((String age) {
            return DropdownMenuItem<String>(
              value: age,
              child: AppText(
                age,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.appText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedAge = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildGenderButton(String text) {
    final isActive = selectedGender == text;
    return Expanded(
      child: PrimaryButton(
        text,
        color: isActive ? AppColors.kPrimary : AppColors.kBgLight2,
        textColor: isActive ? AppColors.kWhite : AppColors.kBlack100,
        pressed: () {
          setState(() {
            selectedGender = text;
          });
        },
      ),
    );
  }
}
