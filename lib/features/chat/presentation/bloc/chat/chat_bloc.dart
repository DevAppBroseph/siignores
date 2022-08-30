import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/features/chat/data/models/chat_message_model.dart';
import 'package:siignores/features/chat/domain/entities/chat_room_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../locator.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/usecases/get_chat.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChat getChat; 
  
  ChatBloc(this.getChat) : super(ChatInitialState());

  ChatRoomEntity chatRoom = ChatRoomEntity(count: 0, users: [], messages: []);
  Stream<dynamic>? streamWS;
  WebSocketChannel? channel;
  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async*{
    if(event is GetChatEvent){
      yield ChatLoadingState();
      var chat = await getChat(event.id);

      yield chat.fold(
        (failure) => errorCheck(failure),
        (data){
          chatRoom = data;
          return GotSuccessChatState();
        }
      );
    }


    if(event is StartSocketEvent){

      try{
        channel = WebSocketChannel.connect(
          Uri.parse('ws://176.113.83.169/ws/${sl<AuthConfig>().token}'),
        );
      }catch(e){
        yield ChatErrorState(message: 'Ошибка с сервером');
      }
      
      if(channel != null){
        channel!.stream.listen((event) {
          print('EVENT WS: ${event}');
          // if(jsonDecode(event)['']){

          // }
          chatRoom.messages.add(ChatMessageModel.fromJson(jsonDecode(event)));
          add(ChatSetStateEvent());
        });
      }
    }


    if(event is SendMessageEvent){
      channel!.sink.add(jsonEncode({
        'chat_id': event.chatId,
        'message': event.message
      }));
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
