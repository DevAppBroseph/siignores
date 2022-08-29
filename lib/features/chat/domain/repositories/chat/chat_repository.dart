import 'package:dartz/dartz.dart';
import 'package:siignores/features/chat/domain/entities/chat_message_entity.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import '../../../../../core/error/failures.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatTabEntity>>> getChatTabs();
  Future<Either<Failure, List<ChatMessageEntity>>> getChat(int params);

}