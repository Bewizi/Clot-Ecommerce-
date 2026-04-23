import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.bgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).colorScheme.appText,
            ),
          ),
        ),
      ),
    );
  }
}
