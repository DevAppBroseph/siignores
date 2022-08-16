part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class RegisterSendCodeOTPEvent extends RegisterEvent {
  final String firstName;  
  final String lastName;  
  final String email;

  RegisterSendCodeOTPEvent({required this.email, required this.firstName, required this.lastName});  
}
class RegisterUserByOTPEvent extends RegisterEvent {
  final String OTP;

  RegisterUserByOTPEvent({required this.OTP});  
}
class RegisterSignInEvent extends RegisterEvent{}

class RegisterErrorEvent extends RegisterEvent {}
