import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:siignores/constants/main_config_app.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  String? avatar;
  final DateTime? lastLogin;
  Color color;

  UserEntity(
      {
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.avatar,
      required this.lastLogin,
      this.color = Colors.black
      });



  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email
      ];
}
