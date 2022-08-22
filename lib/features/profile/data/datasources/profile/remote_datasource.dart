
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';

abstract class ProfileRemoteDataSource {
  Future<bool> updateUserInfo({required String firstName, required String lastName});
  Future<bool> updateAvatar(File avatar);
}

class ProfileRemoteDataSourceImpl
    implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",

  };


  //Update user info
  @override
  Future<bool> updateUserInfo({required String firstName, required String lastName})async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    var formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
    });
    Response response = await dio.patch(Endpoints.updateProfileInfo.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }



  //Update user avatar
  @override
  Future<bool> updateAvatar(File avatar)async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";

    var formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(avatar.path),
    });
    Response response = await dio.put(Endpoints.updateAvatar.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      sl<AuthConfig>().userEntity!.avatar = response.data['photo'];
      return true;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }

}
