import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;

  TodoLoaded(this.todos);
}

class TodoOperationSuccess extends TodoState {
  final String message;

  TodoOperationSuccess(this.message);
}

class TodoError extends TodoState {
  final String errorMessage;

  TodoError(this.errorMessage);
}