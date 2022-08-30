import 'package:dartz/dartz.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/chat_room_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatTabEntity>>> getChatTabs();
  Future<Either<Failure, ChatRoomEntity>> getChat(int params);

}