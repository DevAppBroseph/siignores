

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String? avatar,
    required DateTime? lastLogin,
  }) : super(
    id: id, 
    avatar: avatar,
    firstName: firstName, 
    lastName: lastName, 
    email: email,
    lastLogin: lastLogin,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    firstName: json['firstname'] ?? '',
    lastName: json['lastname'] ?? '',
    email: json['email'] ?? '',
    avatar: json['photo'],
    lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
  );
}