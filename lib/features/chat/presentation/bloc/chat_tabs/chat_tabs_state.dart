part of 'chat_tabs_bloc.dart';

class ChatTabsState extends Equatable {
  const ChatTabsState();
  @override
  List<Object> get props => [];
}

class ChatTabsInitialState extends ChatTabsState {}
class ChatTabsLoadingState extends ChatTabsState {}
class ChatTabsErrorState extends ChatTabsState {
  final String message;
  ChatTabsErrorState({required this.message});
}
class ChatTabsInternetErrorState extends ChatTabsState{}

class GotSuccessChatTabsState extends ChatTabsState{}
