import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../../core/services/database/consts.dart';

abstract class AuthenticationLocalDataSource {
  Future<bool> saveToken(String token);
  Future<bool> deleteToken();
  Future<String?> getToken();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<bool> saveToken(String token) async {
    print("SAVING TOKEN");
    await _storage.write(key: ConstantsForData.ACCESS_TOKEN, value: token);
    return true;
  }

  @override
  Future<String?> getToken() async {
    print("GETTING TOKEN");
    if (await _storage.containsKey(key: ConstantsForData.ACCESS_TOKEN)) {
      var token = await _storage.read(key: ConstantsForData.ACCESS_TOKEN);
      print("TOKEN: ${token}");

      return token;
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteToken() async {
    await _storage.delete(key: ConstantsForData.ACCESS_TOKEN);
    return true;
  }
}
