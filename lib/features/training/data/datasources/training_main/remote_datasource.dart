import 'package:dio/dio.dart';
import 'package:siignores/core/utils/helpers/dio_helper.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';
import '../../../domain/entities/module_entity.dart';
import '../../models/course_model.dart';
import '../../models/module_model.dart';

abstract class TrainingRemoteDataSource {
  Future<List<CourseEntity>> getCourses();
  Future<List<ModuleEntity>> getModules(int moduleId);

}

class TrainingRemoteDataSourceImpl
    implements TrainingRemoteDataSource {
  final Dio dio;

  TrainingRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };


  //Get courses
  @override
  Future<List<CourseEntity>> getCourses() async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
  print('SENT');
    Response response = await dio.get(Endpoints.getCourses.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode == 200) {
      List<CourseModel> data = (response.data as List)
            .map((json) => CourseModel.fromJson(json))
            .toList();
      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }





  //Get courses
  @override
  Future<List<ModuleEntity>> getModules(int moduleId) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    Response response = await dio.get(Endpoints.getModules.getPath(params: [moduleId]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<ModuleModel> data = (response.data as List)
            .map((json) => ModuleModel.fromJson(json))
            .toList();

      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


}
