import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_event.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_state.dart';
import 'package:todo_list_case_study/app/features/todos/ui/todos_form.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    BlocProvider.of<TodoBloc>(context).add(LoadTodos(auth.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Column(
          children: [
            Expanded(child: BlocBuilder<TodoBloc, TodoState>(
              builder: (final context, final state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoLoaded) {
                  final todos = state.todos;
                  return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return SizedBox(
                          child: Card(
                              child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              todo.title ?? "boş",
                              textAlign: TextAlign.start,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined),
                          )),
                        );
                      });
                }
                return const Center(
                  child: Text("Something Went Wrong!"),
                );
              },
            ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodosFormScreen()),
              );
            },
            child: const Icon(Icons.add_outlined),
          ),
        )
      ],
    );
  }
}
