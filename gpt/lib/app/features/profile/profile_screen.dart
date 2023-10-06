import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gpt/app/bloc/app_bloc.dart";
import "package:gpt/app/ui/widgets/revo_home_button.dart";
import "package:gpt/app/ui/widgets/revo_screen_header.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(final BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (final context, final state) async {
        // if (state.deleteAccountEventStatus == EventStatus.success) {
        //   final secureDataStorage = getIt<SecureDataStorage>();
        //   secureDataStorage.deleteAll();
        //   context.router.popUntilRoot();
        //   context.router.popForced();
        //   await context.router.root.replaceAll([const SplashScreenRoute()]);
        // }
      },
      child: Column(
        children: [
          const RevoScreenHeader(
            title: 'AppLocalizations.of(context).profile',
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RevoHomeButton(
                      onPressed: () {},
                      title: 'AppLocalizations.of(context).employee',
                      icon: Icons.badge_outlined,
                    ),
                    RevoHomeButton(
                      onPressed: () {},
                      title: 'AppLocalizations.of(context).vehicleArchive',
                      icon: Icons.archive_outlined,
                    ),
                    RevoHomeButton(
                      onPressed: () {},
                      title: ' AppLocalizations.of(context).drive_archive',
                      icon: Icons.archive_outlined,
                    ),
                    // RevoHomeButton(
                    //   onPressed: () {
                    //     context.router.navigate(const BoughtVehicleListScreenRoute());
                    //   },
                    //   title: AppLocalizations.of(context).boughtVehicles,
                    //   icon: Icons.car_rental_outlined,
                    // ),
                    // RevoHomeButton(
                    //   onPressed: () {
                    //     context.router.navigate(const InviteDealerScreenRoute());
                    //   },
                    //   title: AppLocalizations.of(context).inviteDealer,
                    //   icon: Icons.people_alt_outlined,
                    // ),
                    BlocBuilder<AppBloc, AppState>(
                      builder: (final context, final state) {
                        return ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          onPressed: () async {},
                          label: const Text(
                            'AppLocalizations.of(context).logout.toUpperCase()',
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    TextButton(
                      onPressed: () async {
                        // final secureDataStorage = getIt<SecureDataStorage>();
                        // secureDataStorage.deleteAll();
                        // context.router.popUntilRoot();
                        // context.router.popForced();
                        // await context.router.root.replaceAll([const SplashScreenRoute()]);
                      },
                      child: Text(
                        ' AppLocalizations.of(context).deleteAccount.toUpperCase()',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
