part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  const CalendarState();
  @override
  List<Object> get props => [];
}

class CalendarInitialState extends CalendarState {}
class CalendarLoadingState extends CalendarState {}
class CalendarErrorState extends CalendarState {
  final String message;
  CalendarErrorState({required this.message});
}
class CalendarInternetErrorState extends CalendarState{}

class GotSuccessCalendarState extends CalendarState{}
