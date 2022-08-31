import 'package:dartz/dartz.dart';
import 'package:siignores/features/home/domain/entities/offer_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home/offers_repository.dart';

class GetOffers implements UseCase<List<OfferEntity>, NoParams> {
  final OffersRepository repository;

  GetOffers(this.repository);

  @override
  Future<Either<Failure, List<OfferEntity>>> call(NoParams params) async {
    return await repository.getOffers();
  }
}