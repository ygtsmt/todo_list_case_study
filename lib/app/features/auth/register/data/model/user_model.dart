class UserModel {
  String name;
  String surName;
  String nickName;
  String eMail;
  String phoneNumber;

  UserModel({
    required this.name,
    required this.surName,
    required this.nickName,
    required this.eMail,
    required this.phoneNumber,
  });


  UserModel copyWith({
   String? name,
  String? surName,
  String? nickName,
  String? eMail,
  String? phoneNumber,
  }) {
    return UserModel(
      name: name ?? this.name,
      surName: surName ?? this.surName,
      nickName: nickName ?? this.nickName,
      eMail: eMail ?? this.eMail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}