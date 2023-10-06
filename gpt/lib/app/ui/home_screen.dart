import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_adaptive_ui/flutter_adaptive_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gpt/app/bloc/app_bloc.dart";
import "package:gpt/app/ui/widgets/active_auctions.dart";
import "package:gpt/app/ui/widgets/revo_logo.dart";
import "package:gpt/app/ui/widgets/side_bar.dart";
import "package:gpt/core/injection/injection.dart";
import "package:gpt/core/routes/app_router.dart";
import "package:gpt/generated/l10n.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // getIt<AppBloc>().add(GetGarageEvent());
    // getIt<AppBloc>().add(GetAccountEvent());

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (final context, final state) {
        return AutoTabsRouter(
          routes: const [
            // DashbordTabRouter(),
            // PeTabRouter(),
            // CollectionTabRouter(),
            // AuctionTabRoute(),
            // ProfileTabRouter(),
          ],
          builder: (final context, final child, final animation) {
            final tabsRouter = AutoTabsRouter.of(context);
            final screen = Screen.fromContext(context);

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: const AutoLeadingButton(),
                  elevation: screen.isHandset ? 0 : 1,
                  scrolledUnderElevation: screen.isHandset ? 0 : 1,
                  backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
                  title: const Center(
                    child: SizedBox(
                      height: 40,
                      child: RevoLogo(themeMode: /*  state.themeMode*/ ThemeMode.dark),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (final context) {
                            return const AboutDialog(
                              applicationName: "Revo Garage",
                              applicationVersion: "1.0.0",
                              applicationLegalese: "© 2023 Revo Garage",
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                body: SafeArea(
                  child: AdaptiveBuilder(
                    layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
                      handset: (final BuildContext context, final Screen screen) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: child,
                        );
                      },
                      tablet: (final BuildContext context, final Screen screen) {
                        return Row(
                          children: [
                            const Expanded(
                              child: RevoSideBar(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: child,
                              ),
                            ),
                          ],
                        );
                      },
                      desktop: (final BuildContext context, final Screen screen) {
                        return Row(
                          children: [
                            const Expanded(
                              flex: 3,
                              child: RevoSideBar(),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: child,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height * 0.1,
                                ),
                                child: const ActiveAuctions(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    defaultBuilder: (final BuildContext context, final Screen screen) {
                      return child;
                    },
                  ),
                ),
                bottomNavigationBar: screen.isHandset
                    ? Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: BottomNavigationBar(
                          enableFeedback: true,
                          type: BottomNavigationBarType.fixed,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: const Icon(Icons.dashboard_outlined),
                              label: 'AppLocalizations.of(context).dashboard',
                            ),
                              BottomNavigationBarItem(
                                icon: const Icon(Icons.track_changes),
                                label: 'AppLocalizations.of(context).pAndE',
                              ),
                              BottomNavigationBarItem(
                                icon: const Icon(Icons.directions_car_filled_outlined),
                                label: 'AppLocalizations.of(context).vehicle',
                              ),
                              BottomNavigationBarItem(
                                icon: const Icon(
                                  Icons.gavel_outlined,
                                ),
                                label: 'AppLocalizations.of(context).auction',
                              ),
                            BottomNavigationBarItem(
                              icon: const Icon(Icons.person_outline),
                              label:' AppLocalizations.of(context).profile',
                            ),
                          ],
                          currentIndex: tabsRouter.activeIndex,
                          onTap: tabsRouter.setActiveIndex,
                        ),
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}
