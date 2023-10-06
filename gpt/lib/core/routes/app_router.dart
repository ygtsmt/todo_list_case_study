// ignore_for_file: unused_import

import "package:auto_route/auto_route.dart";
import "package:auto_route/empty_router_widgets.dart";
import "package:flutter/material.dart";
import "package:gpt/app/bloc/app_bloc.dart";
import "package:gpt/app/features/auth/features/create_account/ui/create_account_screen.dart";
import "package:gpt/app/features/collection/collection_screen.dart";
import "package:gpt/app/features/pe/pe_screen.dart";
import "package:gpt/app/features/profile/profile_screen.dart";
import "package:gpt/app/ui/home_screen.dart";
import 'package:gpt/app/features/dashboard/dashboard_screen.dart';
import 'package:gpt/app/features/dashboard/user_summary_screen.dart';
import "package:gpt/core/injection/injection.dart";
import "package:injectable/injectable.dart";

part "app_router.gr.dart";

@MaterialAutoRouter(
  routes: <CustomRoute>[
    CustomRoute(page: SplashScreen, path: "/", initial: true, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: LoginScreen, path: "/login", transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(page: SignupScreen, path: "/register", transitionsBuilder: TransitionsBuilders.fadeIn),

    CustomRoute(
      page: HomeScreen,
      path: "/home",
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        CustomRoute(
          page: EmptyRouterPage,
          name: "DashbordTabRouter",
          path: "dashboard",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          children: [
            CustomRoute(
              page: DashboardScreen,
              path: "dashboard-screen",
              initial: true,
              transitionsBuilder: TransitionsBuilders.fadeIn,
            ),
            CustomRoute(page: UserSummaryScreen, path: "user-summary", transitionsBuilder: TransitionsBuilders.fadeIn),
          ],
        ),
        CustomRoute(
          page: EmptyRouterPage,
          name: "PeTabRouter",
          path: "pe",
          transitionsBuilder: TransitionsBuilders.fadeIn,
         children: [CustomRoute(
              page: PeScreen,
              path: "pe-screen",
              initial: true,
              transitionsBuilder: TransitionsBuilders.fadeIn,
            ),]
        ),
        CustomRoute(
          page: EmptyRouterPage,
          name: "CollectionTabRouter",
          path: "collection",
          transitionsBuilder: TransitionsBuilders.fadeIn,
         children: [
          CustomRoute(
              page: VehicleListScreen,
              path: "vehicles",
              initial: true,
              transitionsBuilder: TransitionsBuilders.fadeIn,
            ),
         ]
        ),
        CustomRoute(
          page: EmptyRouterPage,
          name: "AuctionTabRoute",
          path: "auction",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          guards: [AuctionGuard],
         
        ),
        CustomRoute(
          page: EmptyRouterPage,
          name: "ProfileTabRouter",
          path: "profile",
          transitionsBuilder: TransitionsBuilders.fadeIn,
         children: [CustomRoute(
              page: ProfileScreen,
              path: "profile-screen",
              initial: true,
              transitionsBuilder: TransitionsBuilders.fadeIn,
            ),]
        ),
      ],
    ),
  ],
)
@injectable
class AppRouter extends _$AppRouter {
  AppRouter() : super();
}

@injectable
class AuctionGuard extends AutoRouteGuard {
  @override
  void onNavigation(final NavigationResolver resolver, final StackRouter router) {
    if (false) {
      // if user is authenticated we continue
      resolver.next();
    } else {
      // we redirect the user to our login page
      router.replace(
        const LoginScreenRoute(),
      );
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
