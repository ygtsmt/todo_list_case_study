import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/model/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<void> addUser(UserModel user, String userUID) async {
    return await _firestore.collection('users').doc(userUID).set({
      'name': user.name,
      'surName': user.surName,
      'nickName': user.nickName,
      'eMail': user.eMail,
      'phoneNumber': user.phoneNumber,
      'todos': [],
      'todos_archive': [],
    });
  }
}
