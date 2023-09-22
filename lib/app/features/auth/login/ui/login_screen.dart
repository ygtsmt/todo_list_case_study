import "package:flutter/material.dart";
import "package:flutter_adaptive_ui/flutter_adaptive_ui.dart";
import "package:todo_list_case_study/app/features/auth/login/ui/login_form.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: AdaptiveBuilder(
          layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
            handset: (final BuildContext context, final Screen screen) {
              return const LoginForm();
            },
            tablet: (final BuildContext context, final Screen screen) {
              return const Row(
                children: <Widget>[
                  Expanded(
                    child: Text("SideImage1"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: LoginForm(),
                    ),
                  )
                ],
              );
            },
            desktop: (final BuildContext context, final Screen screen) {
              return const Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text("SideImage2"),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: LoginForm(),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          defaultBuilder: (final BuildContext context, final Screen screen) {
            return const LoginForm();
          },
        ),
      ),
    ));
  }
}
