part of 'notifications_bloc.dart';

class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetNotificationsEvent extends NotificationsEvent{}
class ClearNotificationsEvent extends NotificationsEvent{}
class SetStateNotificationsEvent extends NotificationsEvent{}

