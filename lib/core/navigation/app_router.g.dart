// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashScreenRoute,
  $createAccountRoute,
  $signInRoute,
  $forgotPasswordRoute,
  $otpResetPasswordRoute,
  $aboutYourselfRoute,
  $seeAllCategoriesRoute,
  $categoryProductsRoute,
  $productsRoute,
  $cartPageRoute,
  $checkoutPageRoute,
  $orderSuccessfulPageRoute,
  $orderDetailsPageRoute,
  $appShellRouteData,
];

RouteBase get $splashScreenRoute =>
    GoRouteData.$route(path: '/', factory: $SplashScreenRoute._fromState);

mixin $SplashScreenRoute on GoRouteData {
  static SplashScreenRoute _fromState(GoRouterState state) =>
      SplashScreenRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createAccountRoute => GoRouteData.$route(
  path: '/create-account',
  factory: $CreateAccountRoute._fromState,
);

mixin $CreateAccountRoute on GoRouteData {
  static CreateAccountRoute _fromState(GoRouterState state) =>
      CreateAccountRoute();

  @override
  String get location => GoRouteData.$location('/create-account');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute =>
    GoRouteData.$route(path: '/sign-in', factory: $SignInRoute._fromState);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) => SignInRoute();

  @override
  String get location => GoRouteData.$location('/sign-in');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $forgotPasswordRoute => GoRouteData.$route(
  path: '/forgot-password',
  factory: $ForgotPasswordRoute._fromState,
);

mixin $ForgotPasswordRoute on GoRouteData {
  static ForgotPasswordRoute _fromState(GoRouterState state) =>
      ForgotPasswordRoute();

  @override
  String get location => GoRouteData.$location('/forgot-password');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $otpResetPasswordRoute => GoRouteData.$route(
  path: '/otp-reset-password',
  factory: $OtpResetPasswordRoute._fromState,
);

mixin $OtpResetPasswordRoute on GoRouteData {
  static OtpResetPasswordRoute _fromState(GoRouterState state) =>
      OtpResetPasswordRoute(email: state.uri.queryParameters['email']!);

  OtpResetPasswordRoute get _self => this as OtpResetPasswordRoute;

  @override
  String get location => GoRouteData.$location(
    '/otp-reset-password',
    queryParams: {'email': _self.email},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aboutYourselfRoute => GoRouteData.$route(
  path: '/about-yourself',
  factory: $AboutYourselfRoute._fromState,
);

mixin $AboutYourselfRoute on GoRouteData {
  static AboutYourselfRoute _fromState(GoRouterState state) =>
      AboutYourselfRoute();

  @override
  String get location => GoRouteData.$location('/about-yourself');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $seeAllCategoriesRoute => GoRouteData.$route(
  path: '/see-all-categories',
  factory: $SeeAllCategoriesRoute._fromState,
);

mixin $SeeAllCategoriesRoute on GoRouteData {
  static SeeAllCategoriesRoute _fromState(GoRouterState state) =>
      SeeAllCategoriesRoute();

  @override
  String get location => GoRouteData.$location('/see-all-categories');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $categoryProductsRoute => GoRouteData.$route(
  path: '/category-products/:categoryId/:categoryName',
  factory: $CategoryProductsRoute._fromState,
);

mixin $CategoryProductsRoute on GoRouteData {
  static CategoryProductsRoute _fromState(GoRouterState state) =>
      CategoryProductsRoute(
        categoryId: state.pathParameters['categoryId']!,
        categoryName: state.pathParameters['categoryName']!,
      );

  CategoryProductsRoute get _self => this as CategoryProductsRoute;

  @override
  String get location => GoRouteData.$location(
    '/category-products/${Uri.encodeComponent(_self.categoryId)}/${Uri.encodeComponent(_self.categoryName)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productsRoute => GoRouteData.$route(
  path: '/products/:productId',
  factory: $ProductsRoute._fromState,
);

mixin $ProductsRoute on GoRouteData {
  static ProductsRoute _fromState(GoRouterState state) =>
      ProductsRoute(productId: state.pathParameters['productId']!);

  ProductsRoute get _self => this as ProductsRoute;

  @override
  String get location => GoRouteData.$location(
    '/products/${Uri.encodeComponent(_self.productId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $cartPageRoute =>
    GoRouteData.$route(path: '/cart', factory: $CartPageRoute._fromState);

mixin $CartPageRoute on GoRouteData {
  static CartPageRoute _fromState(GoRouterState state) => CartPageRoute();

  @override
  String get location => GoRouteData.$location('/cart');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $checkoutPageRoute => GoRouteData.$route(
  path: '/checkout',
  factory: $CheckoutPageRoute._fromState,
);

mixin $CheckoutPageRoute on GoRouteData {
  static CheckoutPageRoute _fromState(GoRouterState state) =>
      CheckoutPageRoute();

  @override
  String get location => GoRouteData.$location('/checkout');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orderSuccessfulPageRoute => GoRouteData.$route(
  path: '/order-successful',
  factory: $OrderSuccessfulPageRoute._fromState,
);

mixin $OrderSuccessfulPageRoute on GoRouteData {
  static OrderSuccessfulPageRoute _fromState(GoRouterState state) =>
      OrderSuccessfulPageRoute();

  @override
  String get location => GoRouteData.$location('/order-successful');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orderDetailsPageRoute => GoRouteData.$route(
  path: '/order-details/:orderId',
  factory: $OrderDetailsPageRoute._fromState,
);

mixin $OrderDetailsPageRoute on GoRouteData {
  static OrderDetailsPageRoute _fromState(GoRouterState state) =>
      OrderDetailsPageRoute(orderId: state.pathParameters['orderId']!);

  OrderDetailsPageRoute get _self => this as OrderDetailsPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/order-details/${Uri.encodeComponent(_self.orderId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appShellRouteData => StatefulShellRouteData.$route(
  factory: $AppShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/home', factory: $HomeRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/notification',
          factory: $NotificationPageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/order', factory: $OrderPageRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/profile',
          factory: $ProfilePageRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NotificationPageRoute on GoRouteData {
  static NotificationPageRoute _fromState(GoRouterState state) =>
      NotificationPageRoute();

  @override
  String get location => GoRouteData.$location('/notification');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrderPageRoute on GoRouteData {
  static OrderPageRoute _fromState(GoRouterState state) => OrderPageRoute();

  @override
  String get location => GoRouteData.$location('/order');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfilePageRoute on GoRouteData {
  static ProfilePageRoute _fromState(GoRouterState state) => ProfilePageRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
