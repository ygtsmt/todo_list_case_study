import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/login/ui/login_screen.dart';
import 'package:todo_list_case_study/app/features/profile/bloc/profile_bloc.dart';
import 'package:todo_list_case_study/app/features/profile/bloc/profile_event.dart';
import 'package:todo_list_case_study/app/features/profile/bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile(auth.currentUser!.uid));

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final profile = state.profile;
            return Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${profile.name}  ${profile.surName}",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                      profileText(profile.phoneNumber),
                      profileText(profile.eMail),
                      profileText(profile.nickName),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        }),
        SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'ÇIKIŞ YAP',
              ),
            )),
      ],
    );
  }

  Card profileText(text) {
    return Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ));
  }
}
