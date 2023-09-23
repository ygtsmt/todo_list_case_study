import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/model/user_model.dart';

class FirestoreServiceProfile {
  final CollectionReference _profileCollection = FirebaseFirestore.instance.collection('users');

  Stream<UserModel?> getProfile(String userUid) {
    return _profileCollection.doc(userUid).snapshots().map((doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          eMail: data["eMail"],
          name: data["name"],
          surName: data["surName"],
          nickName: data["nickName"],
          phoneNumber: data["phoneNumber"],
        );
      } else {
        return null;
      }
    });
  }
}
