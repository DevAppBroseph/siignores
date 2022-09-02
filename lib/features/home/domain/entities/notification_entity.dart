import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String message;
  final DateTime time;

  NotificationEntity({
    required this.id,
    required this.time,
    required this.message,
  });



  @override
  List<Object> get props => [
        id,
        time,
        message,

      ];
}
