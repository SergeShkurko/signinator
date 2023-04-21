import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:signinator/dependencies_injection.dart';
import 'package:signinator/features/features.dart';
import 'package:signinator/utils/utils.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),

  /// Home Page
  dashboard("/dashboard"),

  // Auth Page
  login("/auth/login"),
  register("/auth/register"),
  ;

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;
  static final authRoute = GlobalKey<NavigatorState>();

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    navigatorKey: authRoute,
    routes: [
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (_, __) => const SplashScreenPage(),
      ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        builder: (_, __) => const MainPage(),
      ),
      ShellRoute(
        builder: (_, options, child) => AuthPage(child: child),
        routes: [
          GoRoute(
            path: Routes.login.path,
            name: Routes.login.name,
            builder: (_, __) => Provider(
              create: (_) => sl<LoginStore>(),
              child: const LoginPage(),
            ),
          ),
          GoRoute(
            path: Routes.register.path,
            name: Routes.register.name,
            builder: (_, state) => Provider(
              create: (_) => sl<RegisterStore>(),
              child: const RegisterPage(),
            ),
          ),
        ],
      ),
    ],
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    redirect: (_, GoRouterState state) {
      final bool isLoginPage = state.subloc == Routes.login.path ||
          state.subloc == Routes.register.path;

      ///  Check if not login
      ///  if current page is login page we don't need to direct user
      ///  but if not we must direct user to login page
      if (!sl<PrefManager>().isLogin) {
        return isLoginPage ? null : Routes.login.path;
      }

      /// Check if already login and in login page
      /// we should direct user to main page

      if (isLoginPage && sl<PrefManager>().isLogin) {
        return Routes.root.path;
      }

      /// No direct
      return null;
    },
  );
}
