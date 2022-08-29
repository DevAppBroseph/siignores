import 'package:equatable/equatable.dart';

class ChatTabEntity extends Equatable {
  final int id;
  final String chatName;
  final int usersCount;

  ChatTabEntity({
    required this.id,
    required this.chatName,
    required this.usersCount,
  });



  @override
  List<Object> get props => [
        id,
        chatName,
        usersCount
      ];
}
