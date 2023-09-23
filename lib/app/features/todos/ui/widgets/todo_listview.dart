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
              return Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            todo.title ?? "bos",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            todo.description ?? "bos",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            todo.address ?? "bos",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            todo.startDate ?? "bos",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          todo.imageUrl != null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      child: Image.network(todo.imageUrl!),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 100,
                                  child: Text("Görsel Yok"),
                                ),
                          FilledButton.icon(
                              onPressed: () {}, icon: const Icon(Icons.directions), label: const Text("Konum"))
                        ],
                      ),
                    )
                  ],
                ),
              ));
            },
          );
        }
      },
    );
  }
}
