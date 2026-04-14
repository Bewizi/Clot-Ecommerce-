import 'package:clot/features/auth/presentation/pages/create_account/create_account.dart';
import 'package:clot/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:clot/features/auth/presentation/pages/signin/signin.dart';
import 'package:clot/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_router.g.dart';

final appRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: SplashScreenRoute.path,
  // redirect: (context, state) {
  //   final session = Supabase.instance.client.auth.currentSession;
  //   final bool loggedIn = session != null;
  //
  //   if (loggedIn && state.matchedLocation == SplashScreenRoute.path) {
  //     return '/home';
  //   }
  //   return null;
  // },
);

// entry point
@TypedGoRoute<SplashScreenRoute>(path: SplashScreenRoute.path)
class SplashScreenRoute extends GoRouteData with $SplashScreenRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

//  sign up
@TypedGoRoute<CreateAccountRoute>(path: CreateAccountRoute.path)
class CreateAccountRoute extends GoRouteData with $CreateAccountRoute {
  static const path = '/create-account';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateAccount();
}

//  sign in
@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData with $SignInRoute {
  static const path = '/sign-in';

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignIn();
}

// forgot password
@TypedGoRoute<ForgotPasswordRoute>(path: ForgotPasswordRoute.path)
class ForgotPasswordRoute extends GoRouteData with $ForgotPasswordRoute {
  static const path = '/forgot-password';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPassword();
}

/*






// see all homes
@TypedGoRoute<SeeAllHomesRoute>(path: SeeAllHomesRoute.path)
class SeeAllHomesRoute extends GoRouteData with $SeeAllHomesRoute {
  static const path = '/see-all-homes';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SeeAllHomes();
}



// apartment view base on the id
@TypedGoRoute<ApartmentViewRoute>(path: '/apartment-view/:id')
class ApartmentViewRoute extends GoRouteData with $ApartmentViewRoute {
  final String id;

  const ApartmentViewRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ApartmentView(id: id);
}
*/

/*
//MAIN APP SHELL WITH BOTTOM NAV  (NESTED ROUTING)
@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeBranchData>(
      routes: [TypedGoRoute<HomeRoute>(path: '/home')],
    ),
    TypedStatefulShellBranch<SavedBranchData>(
      routes: [TypedGoRoute<SavedPageRoute>(path: '/saved')],
    ),
    TypedStatefulShellBranch<MessagesBranchData>(
      routes: [TypedGoRoute<MessagesPageRoute>(path: '/messages')],
    ),
    TypedStatefulShellBranch<ProfileBranchData>(
      routes: [TypedGoRoute<ProfilePageRoute>(path: '/profile')],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
  }
}


class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();
}

class SavedBranchData extends StatefulShellBranchData {
  const SavedBranchData();
}

class MessagesBranchData extends StatefulShellBranchData {
  const MessagesBranchData();
}

class ProfileBranchData extends StatefulShellBranchData {
  const ProfileBranchData();
}


class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class SavedPageRoute extends GoRouteData with $SavedPageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SavedPage();
}

class MessagesPageRoute extends GoRouteData with $MessagesPageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MessagesPage();
}

class ProfilePageRoute extends GoRouteData with $ProfilePageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}


class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.kPrimary,
        unselectedItemColor: AppColors.kGrey40,
        selectedIconTheme: const IconThemeData(color: AppColors.kPrimary),
        unselectedIconTheme: const IconThemeData(color: AppColors.kGrey40),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kExplore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kSaved),
            label: 'Saved',
            activeIcon: SvgPicture.asset(
              AppSvg.kSaved,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kMessages),
            label: 'Messages',
            activeIcon: SvgPicture.asset(
              AppSvg.kMessages,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kProfile),
            label: 'Profile',
            activeIcon: SvgPicture.asset(
              AppSvg.kProfile,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */
