import 'package:flutter/material.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.red,
        child: const Center(
          child: Column(children: [Text("TODOS SCREEN")]),
        ),
      ),
    );
  }
}
