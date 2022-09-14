import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import 'package:siignores/core/utils/helpers/date_time_helper.dart';
import 'package:siignores/features/home/data/models/calendar_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/calendar_entity.dart';
import '../../../domain/usecases/get_calendar.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetCalendar getCalendar; 
  
  CalendarBloc(this.getCalendar) : super(CalendarInitialState());

  List<CalendarEntity> tasks = [];
  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async*{
    if(event is GetCalendarEvent){
      yield CalendarLoadingState();
      var offer = await getCalendar(NoParams());

      yield offer.fold(
        (failure) => errorCheck(failure),
        (data){
          tasks = data;
          return GotSuccessCalendarState();
        }
      );
    }


    
  }


  CalendarState errorCheck(Failure failure){
    print('FAIL calendar: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return CalendarInternetErrorState();
    }else if(failure is ServerFailure){
      return CalendarErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return CalendarErrorState(message: 'Повторите попытку');
    }
  }

}
