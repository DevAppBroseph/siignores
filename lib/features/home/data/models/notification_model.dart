import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity{
  NotificationModel({
    required int id,
    required String message,
    required DateTime time,
    required int? chatId,

  }) : super(
    id: id, 
    message: message,
    time: time,
    chatId: chatId
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'] ?? 1,
    message: json['message'],
    time: DateTime.parse(json['time']).toLocal(),
    chatId: null
  );
}