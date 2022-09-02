part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object> get props => [];
}

class NotificationsInitialState extends NotificationsState {}
class NotificationsLoadingState extends NotificationsState {}
class NotificationsBlankState extends NotificationsState {}
class NotificationsErrorState extends NotificationsState {
  final String message;
  NotificationsErrorState({required this.message});
}
class NotificationsInternetErrorState extends NotificationsState{}

class GotSuccessNotificationsState extends NotificationsState{}
