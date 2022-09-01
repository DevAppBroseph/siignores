import 'package:dio/dio.dart';
import 'package:siignores/features/home/domain/entities/progress_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';
import '../../../domain/entities/calendar_entity.dart';
import '../../models/calendar_model.dart';
import '../../models/progress_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CalendarEntity>> getCalendar();
  Future<List<ProgressEntity>> getProgress();

}

class HomeRemoteDataSourceImpl
    implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };



  //Get calendar
  @override
  Future<List<CalendarEntity>> getCalendar() async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    Response response = await dio.get(Endpoints.getCalendar.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<CalendarEntity> data = (response.data as List)
            .map((json) => CalendarModel.fromJson(json))
            .toList();
      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }




  //Get progress
  @override
  Future<List<ProgressEntity>> getProgress() async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    Response response = await dio.get(Endpoints.progress.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<ProgressEntity> data = (response.data as List)
            .map((json) => ProgressModel.fromJson(json))
            .toList();
      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }

}
