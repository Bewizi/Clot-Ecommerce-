import 'package:flutter_bloc/flutter_bloc.dart';

final List<BlocProvider> appBlocProvider = [
  // BlocProvider<AuthBloc>(
  //   create: (context) => AuthBloc(AuthRepositoryImpl())..add(CheckAuthStatus()),
  // ),
  // BlocProvider<HomesBloc>(
  //   create: (context) => HomesBloc(
  //     homesRepository: HomesData(),
  //   )..add(FetchHomes()),
  // ),
  // BlocProvider<RecommendedHomesBloc>(
  //   create: (context) => RecommendedHomesBloc(
  //     recommendedHomesRepository: RecommendedHomesData(),
  //   )..add(FetchRecommendedHomes()),
  // ),
  // BlocProvider<ProfileBloc>(
  //   create: (context) =>
  //       ProfileBloc(ProfileRepositoryImpl())..add(LoadProfile()),
  // ),
];
