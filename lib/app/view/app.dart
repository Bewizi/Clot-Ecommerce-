import 'package:clot/core/navigation/app_router.dart';
import 'package:clot/core/provider/bloc_provider.dart';
import 'package:clot/core/theme/app_theme.dart';
import 'package:clot/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appBlocProvider,
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
