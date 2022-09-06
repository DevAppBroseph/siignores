import 'package:dartz/dartz.dart';
import 'package:siignores/core/services/network/network_info.dart';
import 'package:siignores/features/chat/domain/entities/chat_room_entity.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/chat/chat_repository.dart';
import '../datasources/chat/remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ChatRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ChatTabEntity>>> getChatTabs() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getChatTabs();
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ChatRoomEntity>> getChat(int params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getChat(params);
        return Right(items);
      } catch (e) {
        print('$e: eee assasa');
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
