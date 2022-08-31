// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/core/services/network/network_info.dart';
import 'package:siignores/features/home/domain/entities/offer_entity.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home/offers_repository.dart';
import '../datasources/offers/remote_datasource.dart';


class OffersRepositoryImpl implements OffersRepository {
  final OffersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  OffersRepositoryImpl(
      this.remoteDataSource, this.networkInfo);





  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getOffers();
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }






}

