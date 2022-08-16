part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}
class RegisterBlankState extends RegisterState {}

class RegisterViewState extends RegisterState{}
class RegisteredState extends RegisterState{}

class RegisterErrorState extends RegisterState{
  final String message;
  RegisterErrorState({required this.message});
}