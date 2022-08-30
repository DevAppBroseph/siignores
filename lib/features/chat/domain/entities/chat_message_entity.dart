import 'package:equatable/equatable.dart';
import 'package:siignores/features/auth/domain/entities/user_entity.dart';

class ChatMessageEntity extends Equatable {
  final UserEntity from;
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
