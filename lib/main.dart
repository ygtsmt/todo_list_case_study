import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/bloc/bloc/app_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/login/bloc/phone_auth_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/login/data/repository/phone_auth_repository.dart';
import 'package:todo_list_case_study/app/features/auth/login/ui/login_screen.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/register_services.dart';
import 'package:todo_list_case_study/app/features/profile/bloc/profile_bloc.dart';
import 'package:todo_list_case_study/app/features/profile/data/profile_services.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/data/todo_services.dart';
import 'package:todo_list_case_study/core/firebase_options.dart';
import 'package:todo_list_case_study/core/permission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  requestLocationPermission();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PhoneAuthBloc>(
            create: (BuildContext context) => PhoneAuthBloc(phoneAuthRepository: PhoneAuthRepository()),
          ),
          BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc(FirestoreService()),
          ),
          BlocProvider<AppBloc>(
            create: (BuildContext context) => AppBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(FirestoreServiceProfile()),
          ),
          BlocProvider<TodoBloc>(create: (BuildContext context) => TodoBloc(FirestoreServiceTodos())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: const LoginScreen(),
        ));
  }
}
