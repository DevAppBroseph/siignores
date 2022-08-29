import 'package:dartz/dartz.dart';
import 'package:siignores/features/chat/domain/entities/chat_message_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat/chat_repository.dart';

class GetChat implements UseCase<List<ChatMessageEntity>, int> {
  final ChatRepository repository;

  GetChat(this.repository);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call(int params) async {
    return await repository.getChat(params);
  }
}