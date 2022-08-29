import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final int from;
  final String message;
  final DateTime time;

  ChatMessageEntity({
    required this.from,
    required this.message,
    required this.time,
  });



  @override
  List<Object> get props => [
        from,
        message,
        time
      ];
}
