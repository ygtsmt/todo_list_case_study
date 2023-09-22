import 'package:flutter/material.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterOperationSuccess extends RegisterState {
  final String message;

  RegisterOperationSuccess(this.message);
}

class RegisterError extends RegisterState {
  final String errorMessage;

  RegisterError(this.errorMessage);
}
