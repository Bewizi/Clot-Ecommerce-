import 'package:clot/core/variables/app_svg.dart';
import 'package:clot/core/variables/colors.dart';
import 'package:clot/features/auth/presentation/pages/about_yourself/about_yourself.dart';
import 'package:clot/features/auth/presentation/pages/create_account/create_account.dart';
import 'package:clot/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:clot/features/auth/presentation/pages/forgot_password/otp_reset_password.dart';
import 'package:clot/features/auth/presentation/pages/signin/signin.dart';
import 'package:clot/features/home/presentation/pages/home_screen.dart';
import 'package:clot/features/notification_page/presentation/pages/notification_screen.dart';
import 'package:clot/features/order/presentation/pages/order_screen.dart';
import 'package:clot/features/profile/presentation/pages/profile_screen.dart';
import 'package:clot/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_router.g.dart';

final appRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: SplashScreenRoute.path,
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final bool loggedIn = session != null;

    if (loggedIn && state.matchedLocation == SplashScreenRoute.path) {
      return '/home';
    }
    return null;
  },
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

// reset password
@TypedGoRoute<OtpResetPasswordRoute>(path: OtpResetPasswordRoute.path)
class OtpResetPasswordRoute extends GoRouteData with $OtpResetPasswordRoute {
  const OtpResetPasswordRoute({required this.email});

  static const path = '/otp-reset-password';

  final String email;

  @override
  Widget build(BuildContext context, GoRouterState state) => OtpResetPassword(
    email: email,
  );
}

// about yourself
@TypedGoRoute<AboutYourselfRoute>(path: AboutYourselfRoute.path)
class AboutYourselfRoute extends GoRouteData with $AboutYourselfRoute {
  static const path = '/about-yourself';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutYourself();
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

//MAIN APP SHELL WITH BOTTOM NAV  (NESTED ROUTING)
@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeBranchData>(
      routes: [TypedGoRoute<HomeRoute>(path: '/home')],
    ),
    TypedStatefulShellBranch<NotificationBranchData>(
      routes: [TypedGoRoute<NotificationPageRoute>(path: '/notification')],
    ),
    TypedStatefulShellBranch<OrderBranchData>(
      routes: [TypedGoRoute<OrderPageRoute>(path: '/order')],
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

class NotificationBranchData extends StatefulShellBranchData {
  const NotificationBranchData();
}

class OrderBranchData extends StatefulShellBranchData {
  const OrderBranchData();
}

class ProfileBranchData extends StatefulShellBranchData {
  const ProfileBranchData();
}

class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class NotificationPageRoute extends GoRouteData with $NotificationPageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationScreen();
}

class OrderPageRoute extends GoRouteData with $OrderPageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OrderScreen();
}

class ProfilePageRoute extends GoRouteData with $ProfilePageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
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
        unselectedItemColor: AppColors.kBgLight2,
        selectedIconTheme: const IconThemeData(color: AppColors.kPrimary),
        unselectedIconTheme: const IconThemeData(color: AppColors.kBgLight2),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kHome),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              AppSvg.kHome,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kNotificationBing),
            label: 'Notifications',
            activeIcon: SvgPicture.asset(
              AppSvg.kNotificationBing,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kReceipt),
            label: 'Receipts',
            activeIcon: SvgPicture.asset(
              AppSvg.kReceipt,
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
