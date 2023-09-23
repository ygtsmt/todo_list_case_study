import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String uid;
  LoadProfile(this.uid);
}
