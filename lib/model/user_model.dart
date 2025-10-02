// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:furniture_e_commerce/core/utils/app_assets.dart';

class UserModel {
  String uid;
  String userName;
  String email;
  String img;
  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.img,
  });

  UserModel copyWith({
    String? uid,
    String? userName,
    String? email,
    String? img,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'email': email,
      'img': img,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, email: $email, img: $img)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.email == email &&
        other.img == img;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ userName.hashCode ^ email.hashCode ^ img.hashCode;
  }
}
