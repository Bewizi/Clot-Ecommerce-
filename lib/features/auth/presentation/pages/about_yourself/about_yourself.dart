import 'package:clot/core/ui/components/app_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_spacing_extension.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
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
                      color: AppColors.kBlack100,
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
                          color: AppColors.kBlack100,
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
                          color: AppColors.kBlack100,
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
            pressed: (selectedGender != null && selectedAge != null)
                ? () {}
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildAgeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.kBgLight2,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedAge,
          hint: AppText(
            'Age Range',
            style: context.textTheme.titleMedium!.copyWith(
              color: AppColors.kBlack100,
            ),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.kBlack100,
          ),
          items: ages.map((String age) {
            return DropdownMenuItem<String>(
              value: age,
              child: AppText(
                age,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.kBlack100,
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
