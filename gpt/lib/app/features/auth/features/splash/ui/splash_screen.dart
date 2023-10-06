import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gpt/app/features/auth/features/splash/bloc/splash_bloc.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (final context, final state) {},
      child: const Scaffold(
        body: Center(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
