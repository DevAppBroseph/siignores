import 'package:dio/dio.dart';
import 'package:siignores/core/utils/helpers/dio_helper.dart';
import 'package:siignores/features/chat/domain/entities/chat_message_entity.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../core/services/network/endpoints.dart';
import '../../../../../locator.dart';
import '../../models/chat_message_model.dart';
import '../../models/chat_tab_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatTabEntity>> getChatTabs();
  Future<List<ChatMessageEntity>> getChat(int id);

}

class ChatRemoteDataSourceImpl
    implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };


  //Get chat tabs
  @override
  Future<List<ChatTabEntity>> getChatTabs() async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    Response response = await dio.get(Endpoints.getChatTabs.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode == 200) {
      List<ChatTabEntity> data = (response.data['chats'] as List)
            .map((json) => ChatTabModel.fromJson(json))
            .toList();
      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }




  //Get chat
  @override
  Future<List<ChatMessageEntity>> getChat(int id) async {
    headers["Authorization"] = "Token ${sl<AuthConfig>().token}";
    Response response = await dio.get(Endpoints.getChatMessages.getPath(params: [id]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    printRes(response);
    if (response.statusCode == 200) {
      List<ChatMessageEntity> data = (response.data as List)
            .map((json) => ChatMessageModel.fromJson(json))
            .toList();
      return data;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }



}
