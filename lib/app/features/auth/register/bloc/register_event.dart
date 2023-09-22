import 'package:flutter/material.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/model/user_model.dart';

@immutable
abstract class RegisterEvent {}

class AddUser extends RegisterEvent {
  final UserModel user;
  final String userUID;

  AddUser(this.user, this.userUID);
}

