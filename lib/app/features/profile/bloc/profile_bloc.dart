import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/profile/bloc/profile_event.dart';
import 'package:todo_list_case_study/app/features/profile/bloc/profile_state.dart';
import 'package:todo_list_case_study/app/features/profile/data/profile_services.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreServiceProfile _firestoreService;

  ProfileBloc(this._firestoreService) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final profile = await _firestoreService.getProfile(event.uid).first;
        emit(ProfileLoaded(profile!));
      } catch (e) {
        emit(ProfileError('Failed to load profile.'));
      }
    });
  }
}
