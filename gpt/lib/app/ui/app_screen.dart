import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:google_fonts/google_fonts.dart";
import "package:gpt/app/bloc/app_bloc.dart";
import "package:gpt/app/features/auction/bloc/auction_bloc.dart";
import "package:gpt/app/features/auth/features/create_account/bloc/create_account_bloc.dart";
import "package:gpt/app/features/auth/features/login/bloc/login_bloc.dart";
import "package:gpt/app/features/auth/features/splash/bloc/splash_bloc.dart";
import "package:gpt/core/color_schemes.g.dart";
import "package:gpt/core/injection/injection.dart";
import "package:gpt/core/keys.dart";
import "package:gpt/core/routes/app_router.dart";
import "package:gpt/generated/l10n.dart";

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      final String defaultRouteName = WidgetsBinding.instance.window.defaultRouteName;
      if (defaultRouteName != "/") {
        SystemNavigator.routeInformationUpdated(location: "/", replace: true);
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (final context) => getIt<AppBloc>(),
        ),
         BlocProvider<AuctionBloc>(
          create: (final context) => getIt<AuctionBloc>(),
        ),
         BlocProvider<CreateAccountBloc>(
          create: (final context) => getIt<CreateAccountBloc>(),
        ),
         BlocProvider<LoginBloc>(
          create: (final context) => getIt<LoginBloc>(),
        ),
         BlocProvider<SplashBloc>(
          create: (final context) => getIt<SplashBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (final context, final state) {
          return MaterialApp.router(
            scaffoldMessengerKey: snackbarKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              fontFamily: GoogleFonts.lato().fontFamily,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              fontFamily: GoogleFonts.lato().fontFamily,
            ),
            // themeMode: state.themeMode,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
