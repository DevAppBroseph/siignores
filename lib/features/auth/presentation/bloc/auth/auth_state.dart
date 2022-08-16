part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}

class EnterCodeState extends AuthState{
  final String? phone;
  EnterCodeState({required this.phone});
}
class LoginCodeSendedSuccessState extends EnterCodeState{
  final String? phone;
  LoginCodeSendedSuccessState({required this.phone}) : super(phone: phone);
}
class EnterCodeBlankState extends EnterCodeState{
  final String? phone;
  EnterCodeBlankState({required this.phone}) : super(phone: phone);
}
class LoginCodeErrorState extends EnterCodeState{
  final String? phone;
  final String message;
  LoginCodeErrorState({required this.message, required this.phone}) : super(phone: phone);
}


class LoginWithPhoneSuccessState extends AuthState{}

class RequiredRegisterState extends AuthState{}
class RequiredCheckState extends AuthState{}
class RequiredGetUserInfoState extends AuthState{
  bool showModalPromocode;
  String? promocode;
  RequiredGetUserInfoState({required this.showModalPromocode, this.promocode});
}

class InternetConnectionFailed extends AuthState{}

class CheckedState extends AuthState{}
class BlankState extends AuthState{}
class ErrorState extends AuthState{
  final String message;
  ErrorState({required this.message});
}
class InternetErrorState extends AuthState{}
class ServerErrorState extends AuthState{}