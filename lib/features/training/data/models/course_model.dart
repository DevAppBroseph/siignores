import '../../domain/entities/course_entity.dart';

class CourseModel extends CourseEntity{
  CourseModel({
    required int id,
    required String title,
    required String? image,

  }) : super(
    id: id, 
    title: title,
    image: image
  );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json['id'],
    title: json['name'],
    image: json['image'],
    
  );
}