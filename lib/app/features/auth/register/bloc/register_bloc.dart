import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_event.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_state.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/register_services.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirestoreService _firestoreService;

  RegisterBloc(this._firestoreService) : super(RegisterInitial()) {
    on<AddUser>(
      (event, emit) async {
        try {
          emit(RegisterLoading());
          await _firestoreService.addUser(event.user, event.userUID);
          emit(RegisterOperationSuccess('Register successfully.'));
        } catch (e) {
          emit(RegisterError('Failed to register.'));
        }
      },
    );
   
  }
}
