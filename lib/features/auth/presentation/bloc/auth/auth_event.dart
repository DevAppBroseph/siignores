part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LogoutEvent extends AuthEvent {}
class CheckUserLoggedEvent extends AuthEvent {}
class GetUserInfoEvent extends AuthEvent {}



class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
}

class InternetErrorEvent extends AuthEvent {}
class ServerErrorEvent extends AuthEvent {}
