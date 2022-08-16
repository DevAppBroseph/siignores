part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LogoutEvent extends AuthEvent {}
class CheckUserLoggedEvent extends AuthEvent {}
class GetUserInfoEvent extends AuthEvent {}

class OpenAuthFormEvent extends AuthEvent {}


class SendSMSEvent extends AuthEvent {
  final String email;
  SendSMSEvent({required this.email});
}
class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});

}
class RegisterEvent extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  RegisterEvent({required this.email, required this.firstName, required this.lastName, });

}

class InternetErrorEvent extends AuthEvent {}
class ServerErrorEvent extends AuthEvent {}
