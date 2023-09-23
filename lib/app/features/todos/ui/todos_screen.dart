import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/todos/ui/todos_form.dart';
import 'package:todo_list_case_study/app/features/todos/ui/widgets/todo_listview.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        const TodoListView(),
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
