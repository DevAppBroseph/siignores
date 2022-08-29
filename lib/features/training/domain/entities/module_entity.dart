import 'package:equatable/equatable.dart';

class ModuleEntity extends Equatable {
  final int id;
  final String title;
  final String? image;

  ModuleEntity({
    required this.id,
    required this.title,
    required this.image,
  });



  @override
  List<Object> get props => [
        id,
        title,
      ];
}
