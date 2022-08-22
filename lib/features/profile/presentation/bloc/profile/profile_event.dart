part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class UpdateUserInfoEvent extends ProfileEvent{
  final String firstName;
  final String lastName;
  UpdateUserInfoEvent({required this.firstName, required this.lastName});
}
class UpdateAvatarEvent extends ProfileEvent{
  final File file;
  UpdateAvatarEvent({required this.file});
}