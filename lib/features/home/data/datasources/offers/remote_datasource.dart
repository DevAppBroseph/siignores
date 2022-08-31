import 'package:dio/dio.dart';
import 'package:siignores/features/home/data/models/offer_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';
import '../../../domain/entities/offer_entity.dart';

abstract class OffersRemoteDataSource {
  Future<List<OfferEntity>> getOffers();

}

class OffersRemoteDataSourceImpl
    implements OffersRemoteDataSource {
  final Dio dio;

  OffersRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };



  //Get offers
  @override
  Future<List<OfferEntity>> getOffers() async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    Response response = await dio.get(Endpoints.getOffers.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<OfferEntity> data = (response.data as List)
            .map((json) => OfferModel.fromJson(json))
            .toList();

      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }



}
