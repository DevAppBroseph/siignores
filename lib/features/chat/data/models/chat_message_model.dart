import 'package:siignores/features/auth/data/models/user_model.dart';

import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity{
  ChatMessageModel({
    required UserModel from,
    required String message,
    required DateTime time,

  }) : super(
    from: from, 
    time: time,
    message: message
  );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    from: UserModel.fromJson(json['from']),
    time: json['time'] == null ? DateTime.now() : DateTime.parse(json['time']).toLocal(),
    message: json['message'],
  );
}