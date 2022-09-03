import '../../domain/entities/lesson_detail_entity.dart';

class LessonDetailModel extends LessonDetailEntity{
  LessonDetailModel({
    required int id,
    required int moduleId,
    required String title,
    required String text,
    required String? question,
    required String? image,
    required String? status,
    required String? video,
    required String? backImage,
    required List<TimeOfVideo> times,
    required List<LessonFile> files,

  }) : super(
    id: id, 
    title: title,
    image: image,
    moduleId: moduleId,
    text: text,
    question: question,
    status: status,
    video: video,
    times: times,
    files: files,
    backImage: backImage
  );

  factory LessonDetailModel.fromJson(Map<String, dynamic> json) => LessonDetailModel(
    id: json['id'] ?? 1,
    title: json['name'],
    image: json['image'],
    status: json['status'],
    moduleId: json['module'],
    text: json['text'],
    backImage: json['background_image'],
    video: json['video'],
    question: json['question'],
    files: (json['lessonfiles_set'] as List).map((json) => LessonFile.fromJson(json)).toList(),
    times: (json['timer_set'] as List).map((json) => TimeOfVideo.fromJson(json)).toList()
  );
}


class LessonFile{
  final int id;
  final String file;

  LessonFile({
    required this.id,
    required this.file
  });

  factory LessonFile.fromJson(Map<String, dynamic> json) => LessonFile(
    id: json['id'] ?? 1,
    file: json['file'],
    
  );
}


class TimeOfVideo{
  final int id;
  final int hour;
  final int minute;
  final int second;
  final String text;

  TimeOfVideo({
    required this.id,
    required this.hour,
    required this.minute,
    required this.second,
    required this.text
  });

  factory TimeOfVideo.fromJson(Map<String, dynamic> json) => TimeOfVideo(
    id: json['id'] ?? 1,
    hour: int.parse(json['time'].split(":")[0]),
    minute: int.parse(json['time'].split(":")[1]),
    second: int.parse(json['time'].split(":")[2]),
    text: json['text'],
    
  );
}