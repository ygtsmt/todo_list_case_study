
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_event.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_state.dart';
import 'package:todo_list_case_study/app/features/todos/data/todo_services.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FirestoreServiceTodos _firestoreService;

  TodoBloc(this._firestoreService) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      try {
        emit(TodoLoading());
        final todos = await _firestoreService.getTodos(event.uid).first;
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to load todos.'));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.addTodo(event.todo,event.uid);
        emit(TodoOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(TodoError('Failed to add todo.'));
      }
    });
    on<AddTodoArchive>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.addTodoArchive(event.todo,event.uid);
        emit(TodoOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(TodoError('Failed to add todo.'));
      }
    });

    on<UpdateTodo>((event, emit)  async {
      try {
        emit(TodoLoading());
        await _firestoreService.updateTodo(event.todo);
        emit(TodoOperationSuccess('Todo updated successfully.'));
      } catch (e) {
        emit(TodoError('Failed to update todo.'));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.deleteTodo(event.todoId,event.userId);
        emit(TodoOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(TodoError('Failed to delete todo.'));
      }
    });

    on<DeleteTodoArchive>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.deleteTodoArchive(event.todoId,event.userId);
        emit(TodoOperationSuccess('Todo Archived successfully.'));
      } catch (e) {
        emit(TodoError('Failed to delete todo.'));
      }
    });

  }
}