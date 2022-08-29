import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity{
  ChatMessageModel({
    required int from,
    required String message,
    required DateTime time,

  }) : super(
    from: from, 
    time: time,
    message: message
  );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    from: json['from'],
    time: json['time'] == null ? DateTime.now() : DateTime.parse(json['time']).toLocal(),
    message: json['message'],
  );
}