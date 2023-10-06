import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:gpt/app/ui/widgets/revo_home_button.dart";
import "package:gpt/app/ui/widgets/revo_screen_header.dart";
import "package:gpt/core/routes/app_router.dart";
import "package:gpt/generated/l10n.dart";

class PeScreen extends StatelessWidget {
  const PeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        RevoScreenHeader(title: 'AppLocalizations.of(context).pAndE'),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RevoHomeButton(
                    onPressed: () {
                    },
                    title: 'AppLocalizations.of(context).drives',
                    icon: Icons.key_rounded,
                  ),
                  RevoHomeButton(
                    onPressed: () {
                    },
                    title: 'AppLocalizations.of(context).pande_vehicles',
                    icon: Icons.directions_car_filled_rounded,
                  ),
                  RevoHomeButton(
                    onPressed: () {
                    },
                    title:' AppLocalizations.of(context).customers',
                    icon: Icons.people_alt,
                  ),
                  RevoHomeButton(
                    onPressed: () {
                    },
                    title: 'AppLocalizations.of(context).sms',
                    icon: Icons.sms_outlined,
                  ),
                  RevoHomeButton(
                    onPressed: () {
                    },
                    title: 'AppLocalizations.of(context).rights',
                    icon: Icons.list,
                  ),
                  RevoHomeButton(
                    onPressed: () {
                    },
                    title: 'AppLocalizations.of(context).licence_plates',
                    icon: Icons.pin_outlined,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
