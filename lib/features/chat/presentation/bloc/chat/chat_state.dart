part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {}
class ChatLoadingState extends ChatState {}
class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState({required this.message});
}
class ChatInternetErrorState extends ChatState{}

class GotSuccessChatState extends ChatState{}
class ChatBlankState extends ChatState{}
class ChatSetStateState extends ChatState{}
class NewNotificationState extends ChatState{
  final NotificationEntity notificationEntity;
  final int? chatId;
  final bool isNotification;
  NewNotificationState({required this.notificationEntity, required this.chatId, required this.isNotification});
}
