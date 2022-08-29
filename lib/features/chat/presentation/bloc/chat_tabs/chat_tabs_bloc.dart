import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/chat_tab_entity.dart';
import '../../../domain/usecases/get_chat_tabs.dart';
part 'chat_tabs_event.dart';
part 'chat_tabs_state.dart';

class ChatTabsBloc extends Bloc<ChatTabsEvent, ChatTabsState> {
  final GetChatTabs getChatTabs; 
  
  ChatTabsBloc(this.getChatTabs) : super(ChatTabsInitialState());

  List<ChatTabEntity> chatTabs = [];
  @override
  Stream<ChatTabsState> mapEventToState(ChatTabsEvent event) async*{
    if(event is GetChatTabsEvent){
      yield ChatTabsLoadingState();
      var promos = await getChatTabs(NoParams());

      yield promos.fold(
        (failure) => errorCheck(failure),
        (data){
          chatTabs = data;
          return GotSuccessChatTabsState();
        }
      );
    }


    
  }


  ChatTabsState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return ChatTabsInternetErrorState();
    }else if(failure is ServerFailure){
      return ChatTabsErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return ChatTabsErrorState(message: 'Повторите попытку');
    }
  }

}
