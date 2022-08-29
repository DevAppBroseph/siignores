import 'package:dartz/dartz.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat/chat_repository.dart';

class GetChatTabs implements UseCase<List<ChatTabEntity>, NoParams> {
  final ChatRepository repository;

  GetChatTabs(this.repository);

  @override
  Future<Either<Failure, List<ChatTabEntity>>> call(NoParams params) async {
    return await repository.getChatTabs();
  }
}