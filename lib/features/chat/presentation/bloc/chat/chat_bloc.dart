import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/services/network/endpoints.dart';
import 'package:siignores/features/chat/data/models/chat_message_model.dart';
import 'package:siignores/features/chat/domain/entities/chat_room_entity.dart';
import 'package:siignores/features/home/domain/entities/notification_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../locator.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../home/data/models/notification_model.dart';
import '../../../domain/usecases/get_chat.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChat getChat; 
  
  ChatBloc(this.getChat) : super(ChatInitialState());

  ChatRoomEntity chatRoom = ChatRoomEntity(count: 0, users: [], messages: []);
  WebSocketChannel? channel;
  int currentChatId = 0;
  bool isOpened = false;
  
  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async*{
    if(event is GetChatEvent){
      yield ChatLoadingState();
      var chat = await getChat(event.id);

      yield chat.fold(
        (failure) => errorCheck(failure),
        (data){
          currentChatId = event.id;
          chatRoom = data;
          int colorIndex = 0;
          for(int i = 0; i < chatRoom.users.length; i++){
            chatRoom.users[i].color = MainConfigApp.colorsOfUsers[colorIndex];
            if(colorIndex == MainConfigApp.colorsOfUsers.length-1){
              colorIndex = 0;
            }else{
              colorIndex++;
            }
          } 
          return GotSuccessChatState();
        }
      );
    }


    if(event is StartSocketEvent){

      print('URL: ${Endpoints.chatWS.getPath(params: [sl<AuthConfig>().token])}');
      channel = WebSocketChannel.connect(
        Uri.parse(Endpoints.chatWS.getPath(params: [sl<AuthConfig>().token])),
      );
      
      if(channel != null){
        channel!.stream.listen((eventWS) {
          print('EVENT WS: $eventWS');
          // Событие в календаре
          if(jsonDecode(eventWS)['message'] != null && jsonDecode(eventWS)['notifications'] != null){
            add(NewNotificationEvent(notificationEntity: NotificationModel(
              id: 0,
              message: jsonDecode(eventWS)['message'],
              time: DateTime.now(),
              chatId: null
            )));
          // Из чата
          }else if(jsonDecode(eventWS)['chat_id'] != null){
            if(jsonDecode(eventWS)['chat_id'] == currentChatId && jsonDecode(eventWS)['from']['id'] != sl<AuthConfig>().userEntity!.id){
              chatRoom.messages.add(ChatMessageModel.fromJson(jsonDecode(eventWS)));
              add(ChatSetStateEvent());
            }
            if(!(isOpened && jsonDecode(eventWS)['chat_id'] == currentChatId) && jsonDecode(eventWS)['from']['id'] != sl<AuthConfig>().userEntity!.id){
              add(NewNotificationEvent(notificationEntity: NotificationModel(
                id: 0,
                message: 'Сообщение в группе: ${jsonDecode(eventWS)['message']}',
                time: DateTime.now(),
                chatId: jsonDecode(eventWS)['chat_id'])
              ));
            }
          // Событие в календаре
          }
          // else if(jsonDecode(event)['notifications'] == null){
          //   add(NewNotificationEvent(notificationEntity: NotificationModel(
          //     id: 0,
          //     message: jsonDecode(event)['message'] ?? 'Новое событие в календаре',
          //     time: DateTime.now()
          //   ), chatId: null, isNotification: false));
          // }
        },
        onDone: () {
          debugPrint('ws channel closed');
        },
        onError: (error){
          print('SOCKET ERROR: $error');
          if(event.trialsCount < 4){
            channel!.sink.close();
            add(StartSocketEvent(trialsCount: event.trialsCount+1));
          }
        }
        
        );
      }
    }

    if(event is NewNotificationEvent){
      yield ChatBlankState();
      yield NewNotificationState(notificationEntity: event.notificationEntity);
    }


    if(event is SendMessageEvent){
      channel!.sink.add(jsonEncode({
        'chat_id': event.chatId,
        'message': event.message
      }));
      chatRoom.messages.add(ChatMessageModel(from: sl<AuthConfig>().userEntity as UserModel, message: event.message, time: DateTime.now()));
      add(ChatSetStateEvent());

    }

    if(event is ChatSetStateEvent){
      yield ChatBlankState();
      yield ChatSetStateState();
    }

    if(event is CloseSocketEvent){
      channel!.sink.close();
      yield ChatInitialState();
    }
  }


  


  ChatState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return ChatInternetErrorState();
    }else if(failure is ServerFailure){
      return ChatErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return ChatErrorState(message: 'Повторите попытку');
    }
  }

}
