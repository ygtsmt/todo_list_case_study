import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gpt/app/bloc/app_bloc.dart";
import "package:gpt/app/ui/widgets/revo_home_button.dart";
import "package:gpt/app/ui/widgets/revo_screen_header.dart";


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);

    return BlocBuilder<AppBloc, AppState>(
      builder: (final context, final state) {
        return Column(
          children: [
            RevoScreenHeader(
              title: "{AppLocalizations.of(context).welcome}, {state.account?.name ?? ""}",
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    RevoHomeButton(
                      onPressed: () {
                        tabsRouter.setActiveIndex(1);
                      },
                      title: 'AppLocalizations.of(context).pAndE',
                      icon: Icons.track_changes,
                    ),
                    RevoHomeButton(
                      onPressed: () {
                        tabsRouter.setActiveIndex(2);
                      },
                      title: 'AppLocalizations.of(context).vehicle',
                      icon: Icons.directions_car_filled_outlined,
                    ),
                    RevoHomeButton(
                      onPressed: () {
                        tabsRouter.setActiveIndex(3);
                      },
                      title: 'AppLocalizations.of(context).auction',
                      icon: Icons.gavel_outlined,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
