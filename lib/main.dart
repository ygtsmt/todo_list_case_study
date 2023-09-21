import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/login/bloc/bloc/login_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/login/ui/login_screen.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_bloc.dart';
import 'package:todo_list_case_study/core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(),
          ),
          BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: const LoginScreen(),
        ));
  }
}
