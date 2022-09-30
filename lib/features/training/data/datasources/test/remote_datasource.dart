import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siignores/core/utils/helpers/dio_helper.dart';
import 'package:siignores/features/training/data/models/test_model.dart';
import 'package:siignores/features/training/domain/entities/test_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';

abstract class TestRemoteDataSource {
  Future<TestEntity> getTest(int testId);
  Future<bool> sendAnswer(int optionId);
  Future<Map<String, int>> completeTest(int testId);

}

class TestRemoteDataSourceImpl
    implements TestRemoteDataSource {
  final Dio dio;

  TestRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };


  //Get test
  @override
  Future<TestEntity> getTest(int testId) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    Response response = await dio.get(Endpoints.testDetails.getPath(params: [testId]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode == 200) {
      return TestModel.fromJson(response.data);
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }

    // return TestModel(id: 0, title: 'dsadsad dsa ', description: 'dasdas', 
    // allQuestions: 4,
    // correctQuestions: null,
    // isExam: false,
    // questions: 
    //   List.generate(4, (index) 
    //     => QuestionTest(
    //       id: index, 
    //       title: 'Question $index', 
    //       options: [
    //         OptionTest(
    //           id: index, 
    //           text: 'Option 1', 
    //           isCorrect: false
    //         ),
    //         OptionTest(
    //           id: index+1, 
    //           text: 'Option 2', 
    //           isCorrect: true
    //         ),
    //         // OptionTest(
    //         //   id: index+2, 
    //         //   text: 'Option 3', 
    //         //   isCorrect: false
    //         // ),
    //         // OptionTest(
    //         //   id: index+3, 
    //         //   text: 'Option 4', 
    //         //   isCorrect: false
    //         // )
    //       ], 
    //       unanswered: index != 0
    //     ))
    //   );
  }



  @override
  Future<bool> sendAnswer(int optionId) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    print('OPTION; ${optionId}');
    Response response = await dio.post(Endpoints.testAnswer.getPath(),
        data: jsonEncode({'option': optionId}),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    print('OPTION; ${response.realUri}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }

  @override
  Future<Map<String, int>> completeTest(int testId) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    Response response = await dio.delete(Endpoints.testAnswer.getPath(),
        data: jsonEncode({'test': testId}),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode == 200) {
      return {
        'your_result': response.data['your_result'],
        'all_questions': response.data['all_questions']
      };
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }

}
