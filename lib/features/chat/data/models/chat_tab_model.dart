import '../../domain/entities/chat_tab_entity.dart';

class ChatTabModel extends ChatTabEntity{
  ChatTabModel({
    required int id,
    required String chatName,
    required int usersCount,

  }) : super(
    id: id, 
    chatName: chatName,
    usersCount: usersCount
  );

  factory ChatTabModel.fromJson(Map<String, dynamic> json) => ChatTabModel(
    id: json['chat_id'],
    chatName: json['chat_name'],
    usersCount: json['users_count'],
  );
}