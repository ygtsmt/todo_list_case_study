import "package:flutter/material.dart";
import "package:flutter_adaptive_ui/flutter_adaptive_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_list_case_study/app/bloc/app_bloc.dart";
import "package:todo_list_case_study/app/features/profile/ui/profile_screen.dart";
import "package:todo_list_case_study/app/features/todos/ui/todos_screen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int bottomNavBarCurrentIndex = 0;

  final List<Widget> bottomNavBarPages = [
    const TodosScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (final context, final state) {
        final screen = Screen.fromContext(context);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: screen.isHandset ? 0 : 1,
              scrolledUnderElevation: screen.isHandset ? 0 : 1,
              backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
              title: const Center(
                child: SizedBox(
                  height: 40,
                  child: Text("Todos App"),
                ),
              ),
            ),
            body: SafeArea(
              child: AdaptiveBuilder(
                layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
                  handset: (final BuildContext context, final Screen screen) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: bottomNavBarPages[bottomNavBarCurrentIndex],
                    );
                  },
                  tablet: (final BuildContext context, final Screen screen) {
                    return Row(
                      children: [
                        const Expanded(
                          child: FlutterLogo(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: bottomNavBarPages[bottomNavBarCurrentIndex],
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
                          child: FlutterLogo(),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: bottomNavBarPages[bottomNavBarCurrentIndex],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.1,
                            ),
                            child: const FlutterLogo(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                defaultBuilder: (final BuildContext context, final Screen screen) {
                  return bottomNavBarPages[bottomNavBarCurrentIndex];
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
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.today_outlined),
                          label: 'TODOS',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline_outlined),
                          label: "PROFİL",
                        ),
                      ],
                      currentIndex: bottomNavBarCurrentIndex,
                      onTap: (int index) {
                        setState(() {
                          bottomNavBarCurrentIndex = index;
                        });
                      },
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
