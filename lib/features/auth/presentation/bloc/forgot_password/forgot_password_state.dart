part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object> get props => [];
}

class FPInitialState extends ForgotPasswordState {}
class FPBlankState extends ForgotPasswordState {}

class FPViewState extends ForgotPasswordState{}
// class ForgotPasswordedState extends ForgotPasswordState{}
class ForgotPasswordCompletedState extends ForgotPasswordState{}

class FPErrorState extends ForgotPasswordState{
  final String message;
  FPErrorState({required this.message});
}