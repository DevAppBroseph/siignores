import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  String? avatar;
  final DateTime? lastLogin;

  UserEntity(
      {
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.avatar,
      required this.lastLogin,
      });



  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email
      ];
}
