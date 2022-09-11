import 'package:equatable/equatable.dart';

class ChatTabEntity extends Equatable {
  final int id;
  final String chatName;
  final int usersCount;
  final bool flag;
  final String? linkTelegram;

  ChatTabEntity({
    required this.id,
    required this.chatName,
    required this.usersCount,
    required this.flag,
    required this.linkTelegram,
  });



  @override
  List<Object> get props => [
        id,
        chatName,
        usersCount,
        flag
      ];
}
