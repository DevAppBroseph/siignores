import 'package:equatable/equatable.dart';

class ModuleEntity extends Equatable {
  final int id;
  final String title;
  final bool perm;
  final String? description;
  final String? image;

  ModuleEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.perm,
    required this.description
  });



  @override
  List<Object> get props => [
        id,
        title,
      ];
}
