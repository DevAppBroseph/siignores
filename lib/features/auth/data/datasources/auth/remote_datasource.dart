import 'package:dio/dio.dart';
import 'package:siignores/core/utils/helpers/dio_helper.dart';
import 'package:siignores/features/auth/data/models/user_model.dart';
import 'package:siignores/features/auth/domain/entities/reset_data_enitiy.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';

abstract class AuthenticationRemoteDataSource {
  Future<bool> register({required String email, required String firstName, required String lastName});
  Future<bool> activationCode(String email, String code);
  Future<String?> setPassword(String email, String password);

  Future<String> login(String email, String password);
  Future<UserModel> getUserInfo();
  Future<void> logout();

  //Forgot password
  Future<bool> sendCodeForResetPassword(String email);
  Future<ResetDataEntity> verifyCodeForResetPassword(String email, String code);
  Future<bool> resetPassword(ResetDataEntity resetDataEntity, String password);
  

}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };


  @override
  Future<String> login(String email, String password) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "email": email, 
      "password": password
    });

    Response response = await dio.post(Endpoints.login.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return response.data['auth_token'];
    } else if(response.statusCode == 400) {
      throw ServerException(message: 'Не правильный логин или пароль');
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }

  @override
  Future<bool> register({required String email, required String firstName, required String lastName}) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "email": email, 
      "firstname": firstName,
      "lastname": lastName,
    });
    Response response = await dio.post(Endpoints.register.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return true;
    } else if(response.statusCode == 400 && response.data.toString().contains('custom user with this email already exists')){
      throw ServerException(message: 'Пользователь с таким email-ом уже существует');
    }else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


  @override
  Future<UserModel> getUserInfo() async {
    print('GETTING USER INFO');
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    Response response = await dio.get(Endpoints.getUserInfo.getPath(),
        options: Options(
          headers: headers,
          validateStatus: (status) => status! < 501,
        ));
    print('GOT USER INFO: ${response.statusCode}');
    printRes(response);
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else if(response.statusCode == 401) {
      return UserModel(firstName: 'unauthorized', lastLogin: null, lastName: '', email: '');
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }




   @override
  Future<bool> activationCode(String email, String code) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "email": email, 
      "registration_code": int.parse(code), 
    });

    Response response = await dio.post(Endpoints.activationCode.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return true;
    } else if(response.statusCode == 400) {
      throw ServerException(message: 'Не правильный код');
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


   @override
  Future<String?> setPassword(String email, String password) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "email": email, 
      "password": password, 
    });

    Response response = await dio.post(Endpoints.setPassword.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return response.data['auth_token'];
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }




   @override
  Future<void> logout() async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    Response response = await dio.post(Endpoints.logout.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
  }













  //Forgot password

   @override
  Future<bool> sendCodeForResetPassword(String email) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "email": email, 
    });

    Response response = await dio.post(Endpoints.sendCodeForResetPassword.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return true;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }



   @override
  Future<ResetDataEntity> verifyCodeForResetPassword(String email, String code) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "email": email, 
      "registration_code": int.parse(code), 
    });
    Response response = await dio.post(Endpoints.verifyCodeForResetPassword.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return ResetDataEntity(
        uid: response.data['uid'],
        token: response.data['token'],
      );
    } else if(response.statusCode == 400) {
      throw ServerException(message: 'Не правильный код');
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


   @override
  Future<bool> resetPassword(ResetDataEntity resetDataEntity, String password) async {
    headers.remove("Authorization");
    var formData = FormData.fromMap({
      "uid": resetDataEntity.uid, 
      "token": resetDataEntity.token, 
      "new_password": password, 
    });

    Response response = await dio.post(Endpoints.resetPassword.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return true;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


}
