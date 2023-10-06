import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:gpt/app/ui/widgets/revo_home_button.dart";
import "package:gpt/app/ui/widgets/revo_screen_header.dart";
import "package:gpt/core/routes/app_router.dart";
import "package:gpt/generated/l10n.dart";

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RevoScreenHeader(title: AppLocalizations.of(context).auction),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RevoHomeButton(
                onPressed: () {
                
                },
                title: AppLocalizations.of(context).auction,
                icon: Icons.gavel_outlined,
              ),
              RevoHomeButton(
                onPressed: () {},
                title: AppLocalizations.of(context).myVehicle,
                icon: Icons.format_list_numbered_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
