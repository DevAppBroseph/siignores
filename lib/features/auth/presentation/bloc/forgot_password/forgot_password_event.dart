part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class FPSendCodeEvent extends ForgotPasswordEvent {
  final String email;
  FPSendCodeEvent({required this.email});  
}
class FPVerifyCodeEvent extends ForgotPasswordEvent {
  final String code;
  FPVerifyCodeEvent({required this.code});  
}
class FPSetPasswordEvent extends ForgotPasswordEvent{
  final String password;
  FPSetPasswordEvent({required this.password });
}
class FPBackEvent extends ForgotPasswordEvent{}
