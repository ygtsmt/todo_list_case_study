import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';

class FirestoreServiceTodos {
  final CollectionReference _todosCollection = FirebaseFirestore.instance.collection('todos');

  Stream<List<TodoModel>> getTodos(String userUid) {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(userUid);

    return userDocRef.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return [];
      }

      final userData = snapshot.data() as Map<String, dynamic>;
      final todosData = userData['todos'] as List<dynamic>;

      return todosData.map((todo) {
        return TodoModel(
          id: todo['id'],
          title: todo['title'],
          description: todo['description'],
          address: todo['address'],
          startDate: todo['startDate'],
          finishDate: todo['finishDate'],
          location: todo['location'],
        );
      }).toList();
    });
  }

  Future<void> addTodo(TodoModel todo, String userUid) async {
    try {
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(userUid);

      await userDocRef.update({
        'todos': FieldValue.arrayUnion([
          {
            'id': todo.id,
            'title': todo.title,
            'description': todo.description,
            'address': todo.address,
            'startDate': todo.startDate,
            'finishDate': todo.finishDate,
            'location': todo.location,
          }
        ])
      });
    } catch (error) {
      print("Hata: $error");
    }
  }

  Future<void> updateTodo(TodoModel todo) {
    return _todosCollection.doc(todo.id).update({
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'address': todo.address,
      'startDate': todo.startDate,
      'finishDate': todo.finishDate,
      'location': todo.location,
    });
  }

  Future<void> deleteTodo(String todoId) {
    return _todosCollection.doc(todoId).delete();
  }
}
