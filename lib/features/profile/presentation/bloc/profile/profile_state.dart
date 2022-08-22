part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}
class ProfileBlankState extends ProfileState {}
class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
class InternetConnectionFailureProfileState extends ProfileState {}

class ChangedSuccessState extends ProfileState{}
