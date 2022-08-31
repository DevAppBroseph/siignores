import 'package:dartz/dartz.dart';
import 'package:siignores/features/home/domain/entities/offer_entity.dart';
import '../../../../../core/error/failures.dart';

abstract class OffersRepository {
  Future<Either<Failure, List<OfferEntity>>> getOffers();

}