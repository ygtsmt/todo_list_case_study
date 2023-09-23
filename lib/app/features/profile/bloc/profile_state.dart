import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/model/user_model.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel profile;

  ProfileLoaded(this.profile);
}

class ProfileOperationSuccess extends ProfileState {
  final String message;

  ProfileOperationSuccess(this.message);
}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError(this.errorMessage);
}
