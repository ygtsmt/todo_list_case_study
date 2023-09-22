import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';

@immutable
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {
  final String uid;
  LoadTodos(this.uid);
}

class AddTodo extends TodoEvent {
  final TodoModel todo;
  final String uid;

  AddTodo(this.todo, this.uid);
}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;

  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final String todoId;

  DeleteTodo(this.todoId);
}
