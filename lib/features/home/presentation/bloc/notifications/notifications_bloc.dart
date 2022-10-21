import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import 'package:siignores/features/home/data/models/notification_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/usecases/get_notifications.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotifications getNotifications; 
  
  NotificationsBloc(this.getNotifications) : super(NotificationsInitialState());

  List<NotificationEntity> notifications = [];
  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async*{
    if(event is GetNotificationsEvent){
      yield NotificationsLoadingState();
      var offer = await getNotifications(NoParams());

      yield offer.fold(
        (failure) => errorCheck(failure),
        (data){
          notifications = data;
          notifications.add(
            NotificationModel(id: 0, message: 'Message from', time: DateTime.now(), chatId: null)
          );
          return GotSuccessNotificationsState();
        }
      );
    }

    if(event is ClearNotificationsEvent){
      yield NotificationsBlankState();
      notifications.clear();
      yield GotSuccessNotificationsState();
    }

    
  }


  NotificationsState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return NotificationsInternetErrorState();
    }else if(failure is ServerFailure){
      return NotificationsErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return NotificationsErrorState(message: 'Повторите попытку');
    }
  }

}
