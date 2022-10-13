part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetChatEvent extends ChatEvent{
  final int id;
  GetChatEvent({required this.id});
}

class StartSocketEvent extends ChatEvent{}
class CloseSocketEvent extends ChatEvent{}
class SendMessageEvent extends ChatEvent{
  final int chatId;
  final String message;
  SendMessageEvent({required this.chatId, required this.message});
}


class ChatSetStateEvent extends ChatEvent{}
class NewNotificationEvent extends ChatEvent{
  final NotificationEntity notificationEntity;
  final int? chatId;
  final bool isNotification;
  NewNotificationEvent({required this.notificationEntity, required this.chatId, required this.isNotification});
}