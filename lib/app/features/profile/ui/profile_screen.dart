import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.red,
        child: const Center(
          child: Column(children: [Text("PROFILE SCREEN")]),
        ),
      ),
    );
  }
}
