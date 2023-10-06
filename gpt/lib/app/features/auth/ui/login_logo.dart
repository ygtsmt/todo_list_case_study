import "package:flutter/material.dart";
import "package:flutter_adaptive_ui/flutter_adaptive_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gpt/app/bloc/app_bloc.dart";
import "package:gpt/app/ui/widgets/revo_logo.dart";

class LoginLogo extends StatelessWidget {
  const LoginLogo({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (final context, final state) {
        return AdaptiveBuilder(
          layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
            handset: (final BuildContext context, final Screen screen) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const RevoLogo(/* themeMode: state.themeMode */),
              );
            },
            tablet: (final BuildContext context, final Screen screen) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: const RevoLogo(/* themeMode: state.themeMode */),
              );
            },
            desktop: (final BuildContext context, final Screen screen) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 8,
                child: const RevoLogo(/* themeMode: state.themeMode */),
              );
            },
          ),
          defaultBuilder: (final BuildContext context, final Screen screen) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const RevoLogo(/* themeMode: state.themeMode */),
            );
          },
        );
      },
    );
  }
}
