part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}

class RequiredCheckState extends AuthState{}
class RequiredGetUserInfoState extends AuthState{}

class CheckedState extends AuthState{}
class BlankState extends AuthState{}
class ErrorState extends AuthState{
  final String message;
  const ErrorState({required this.message});
}
class InternetErrorState extends AuthState{}
class ServerErrorState extends AuthState{}