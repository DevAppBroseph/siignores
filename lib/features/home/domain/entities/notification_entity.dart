import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String message;
  final DateTime time;
  final int? chatId;

  NotificationEntity({
    required this.id,
    required this.time,
    required this.message,
    required this.chatId
  });



  @override
  List<Object> get props => [
        id,
        time,
        message,

      ];
}
