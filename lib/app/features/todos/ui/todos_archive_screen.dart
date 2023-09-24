import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_event.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';
import 'package:todo_list_case_study/app/features/todos/data/todo_services.dart';

class TodoArchiveScreen extends StatelessWidget {
  const TodoArchiveScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<TodoModel>>(
              stream: FirestoreServiceTodos().getTodosArchive(auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Henüz hiç todo arşivlenmemiş.'));
                } else {
                  final todos = snapshot.data;
                  return ListView.builder(
                    itemCount: todos!.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      final startDateTime = todo.startDate!.toDate();
                      final finishDateTime = todo.finishDate!.toDate();
                      final difference = finishDateTime.difference(startDateTime);

                      return Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        todo.title ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        todo.description ?? "",
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Yer: ${todo.address ?? ""}",
                                        style: Theme.of(context).textTheme.titleSmall,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${difference.inDays} gün kaldı",
                                        style: Theme.of(context).textTheme.titleSmall,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      if (todo.imageUrl!.length > 10)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 100,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  child: Image.network(todo.imageUrl!)),
                                            ),
                                          ),
                                        )
                                      else
                                        const SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              "Görsel Yok",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton.outlined(
                                              onPressed: () {
                                                BlocProvider.of<TodoBloc>(context)
                                                    .add(DeleteTodoArchive(todo.id!, auth.currentUser!.uid));
                                              },
                                              icon: const Icon(Icons.archive_outlined)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
