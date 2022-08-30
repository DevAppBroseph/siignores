import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_room_entity.dart';
import '../repositories/chat/chat_repository.dart';

class GetChat implements UseCase<ChatRoomEntity, int> {
  final ChatRepository repository;

  GetChat(this.repository);

  @override
  Future<Either<Failure, ChatRoomEntity>> call(int params) async {
    return await repository.getChat(params);
  }
}