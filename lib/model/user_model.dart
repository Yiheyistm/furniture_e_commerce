import 'package:furniture_e_commerce/core/utils/app_assets.dart';

class UserModel {
  String uid;
  String userName;
  String email;
  String img;

  UserModel(
    this.uid,
    this.userName,
    this.email,
    this.img,
  );
  factory UserModel.empty() {
    return UserModel('', 'No Name', 'No Email', AppAssets.profileUrl);
  }
  UserModel copyWith({
    String? uid,
    String? userName,
    String? email,
    String? img,
  }) {
    return UserModel(
      uid ?? this.uid,
      userName ?? this.userName,
      email ?? this.email,
      img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'img': img,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['uid'] ?? '',
      map['userName'] ?? '',
      map['email'] ?? '',
      map['img'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, email: $email, img: $img)';
  }
}
