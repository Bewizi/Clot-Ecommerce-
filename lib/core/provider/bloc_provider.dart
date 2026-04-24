import 'package:clot/features/auth/data/auth_data.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<BlocProvider> appBlocProvider = [
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(AuthData()),
  ),
];
