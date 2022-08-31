import 'dart:io';
import 'package:dio/dio.dart';
import 'package:siignores/core/utils/helpers/dio_helper.dart';
import 'package:siignores/features/training/data/models/lesson_detail_model.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import 'package:siignores/features/training/domain/entities/lesson_detail_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';
import '../../../domain/entities/lesson_list_entity.dart';
import '../../../domain/entities/module_enitiy.dart';
import '../../models/course_model.dart';
import '../../models/lesson_list_model.dart';
import '../../models/module_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

abstract class TrainingRemoteDataSource {
  Future<List<CourseEntity>> getCourses();
  Future<List<ModuleEntity>> getModules(int moduleId);

  Future<List<LessonListEntity>> getLessons(int moduleId);
  Future<LessonDetailEntity> getLesson(int lessonId);

  Future<bool> sendHomework(List<File> files, String text, int lessonId);

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






  //Get lessons
  @override
  Future<List<LessonListEntity>> getLessons(int moduleId) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    Response response = await dio.get(Endpoints.getLessons.getPath(params: [moduleId]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<LessonListEntity> data = (response.data as List)
            .map((json) => LessonListModel.fromJson(json))
            .toList();

      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }








  //Get lesson detail
  @override
  Future<LessonDetailEntity> getLesson(int lessonId) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    Response response = await dio.get(Endpoints.getLesson.getPath(params: [lessonId]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));

    print('RES: ${response.data}');
    printRes(response);
    if (response.statusCode == 200) {
      LessonDetailEntity data = LessonDetailModel.fromJson(response.data);
      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }







  //Update user avatar
  @override
  Future<bool> sendHomework(List<File> files, String text, int lessonId)async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    headers["Content-Type"] = "multipart/form-data";
    List<MultipartFile> multiparts = [];
    
    for (int i = 0; i < files.length; i++) {
      multiparts.add( MultipartFile.fromFileSync(
        '${files[i].path}',
        filename: (basename(files[i].path)).toString(),
        contentType: new MediaType('image', 'jpeg'),
      ));
    }
    var formData = FormData.fromMap({
      "lesson": lessonId,
      "text": text,
      "files": files.isNotEmpty ? multiparts : [],
    });
    Response response = await dio.post(Endpoints.addHomework.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }
}
