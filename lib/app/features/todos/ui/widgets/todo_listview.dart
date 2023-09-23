import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';
import 'package:todo_list_case_study/app/features/todos/data/todo_services.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return StreamBuilder<List<TodoModel>>(
      stream: FirestoreServiceTodos().getTodos(auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Henüz hiç todo eklenmemiş.'));
        } else {
          final todos = snapshot.data;
          return ListView.builder(
            itemCount: todos!.length,
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
            },
          );
        }
      },
    );
  }

  
}
