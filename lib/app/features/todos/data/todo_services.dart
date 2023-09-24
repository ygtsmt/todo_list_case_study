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
          imageUrl: todo['imageUrl'],
        );
      }).toList();
    });
  }
  Stream<List<TodoModel>> getTodosArchive(String userUid) {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(userUid);

    return userDocRef.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return [];
      }

      final userData = snapshot.data() as Map<String, dynamic>;
      final todosData = userData['todos_archive'] as List<dynamic>;

      return todosData.map((todo) {
        return TodoModel(
          id: todo['id'],
          title: todo['title'],
          description: todo['description'],
          address: todo['address'],
          startDate: todo['startDate'],
          finishDate: todo['finishDate'],
          location: todo['location'],
          imageUrl: todo['imageUrl'],
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
            'imageUrl': todo.imageUrl,
          }
        ])
      });
    } catch (error) {
      print("Hata: $error");
    }
  }

  Future<void> addTodoArchive(TodoModel todo, String userUid) async {
    try {
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(userUid);

      await userDocRef.update({
        'todos_archive': FieldValue.arrayUnion([
          {
            'id': todo.id,
            'title': todo.title,
            'description': todo.description,
            'address': todo.address,
            'startDate': todo.startDate,
            'finishDate': todo.finishDate,
            'location': todo.location,
            'imageUrl': todo.imageUrl,
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
      'imageUrl': todo.imageUrl,
    });
  }

  Future<void> deleteTodo(
    String todoId,
    String userUid,
  ) async {
    try {
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(userUid);

      final userDoc = await userDocRef.get();

      if (userDoc.exists) {
        final todosList = userDoc.data()?['todos'] as List<dynamic>?;

        if (todosList != null) {
          final updatedTodos = todosList.where((todo) => todo['id'] != todoId).toList();

          await userDocRef.update({'todos': updatedTodos});
        }
      }
    } catch (e) {
      print("Hata: $e");
    }
  }
}
