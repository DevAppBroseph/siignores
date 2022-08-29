import 'package:siignores/features/training/domain/entities/module_entity.dart';

class ModuleModel extends ModuleEntity{
  ModuleModel({
    required int id,
    required String title,
    required String? image,

  }) : super(
    id: id, 
    title: title,
    image: image
  );

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
    id: json['id'] ?? 1,
    title: json['name'],
    image: json['image'],
    
  );
}