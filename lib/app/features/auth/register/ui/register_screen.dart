import "package:flutter/material.dart";
import "package:flutter_adaptive_ui/flutter_adaptive_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_list_case_study/app/features/auth/register/bloc/register_bloc.dart";
import "package:todo_list_case_study/app/features/auth/register/bloc/register_state.dart";
import "package:todo_list_case_study/app/features/auth/register/ui/register_form.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (final context, final state) {},
        builder: (final context, final state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: AdaptiveBuilder(
                layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
                  handset: (final BuildContext context, final Screen screen) {
                    return const RegisterForm();
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
                            child: RegisterForm(),
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
                                child: RegisterForm(),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                defaultBuilder: (final BuildContext context, final Screen screen) {
                  return const RegisterForm();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
