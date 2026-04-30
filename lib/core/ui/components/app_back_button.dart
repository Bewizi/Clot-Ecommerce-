import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/ui/extensions/app_color_extension.dart';
import 'package:clot/features/auth/presentation/pages/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          if (GoRouter.of(context).canPop()) {
            context.pop();
          } else {
            SignInRoute().go(context);
          }
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
