import 'package:equatable/equatable.dart';
import 'package:siignores/features/auth/domain/entities/user_entity.dart';
import 'package:siignores/features/chat/domain/entities/chat_message_entity.dart';

class ChatRoomEntity extends Equatable {
  final int count;
  final List<UserEntity> users;
  final List<ChatMessageEntity> messages;

  ChatRoomEntity({
    required this.count,
    required this.users,
    required this.messages,
  });



  @override
  List<Object> get props => [
      count,
      users,
      messages
      ];
}
