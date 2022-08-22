part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class RegisterByInfoEvent extends RegisterEvent {
  final String firstName;  
  final String lastName;  
  final String email;

  RegisterByInfoEvent({required this.email, required this.firstName, required this.lastName});  
}
class RegisterActivationCodeEvent extends RegisterEvent {
  final String code;
  RegisterActivationCodeEvent({required this.code});  
}
class RegisterSignInEvent extends RegisterEvent {}
class RegisterSetPasswordEvent extends RegisterEvent{
  final String password;
  RegisterSetPasswordEvent({required this.password });
}
class RegisterBackEvent extends RegisterEvent{}
