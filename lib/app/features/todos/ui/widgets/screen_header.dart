import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';
import 'package:todo_list_case_study/app/features/todos/data/todo_services.dart';

class ScreenHeader extends StatelessWidget {
  final String userId;
  const ScreenHeader({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      stream: FirestoreServiceTodos().getTodos(userId),
      builder: (context, todosSnapshot) {
        if (todosSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (todosSnapshot.hasError) {
          return Center(child: Text('Hata: ${todosSnapshot.error}'));
        } else {
          final todos = todosSnapshot.data;
          final activeTodosCount = todos!.length;

          return StreamBuilder<List<TodoModel>>(
            stream: FirestoreServiceTodos().getTodosArchive(userId),
            builder: (context, archiveSnapshot) {
              if (archiveSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (archiveSnapshot.hasError) {
                return Center(child: Text('Hata: ${archiveSnapshot.error}'));
              } else {
                final archiveTodos = archiveSnapshot.data;
                final archivedTodosCount = archiveTodos!.length;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Aktif Notlar: $activeTodosCount"),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Arşivlenenler Notlar: $archivedTodosCount"),
                          ),
                        ),
                        FilledButton.icon(
                          label: const Text("Arşiv"),
                          onPressed: () {},
                          icon: const Icon(Icons.archive_outlined),
                        ),
                      ],
                    ),
                    
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}
