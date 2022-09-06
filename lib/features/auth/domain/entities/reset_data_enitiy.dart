import 'package:equatable/equatable.dart';

class ResetDataEntity extends Equatable {
  final String uid;
  final String token;

  const ResetDataEntity({
    // required this.id,
    required this.uid,
    required this.token,
  });

  @override
  List<Object> get props => [uid, token];
}
