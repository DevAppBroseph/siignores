import '../../domain/entities/lesson_detail_entity.dart';

class LessonDetailModel extends LessonDetailEntity {
  LessonDetailModel({
    required int id,
    required int moduleId,
    required int lessonNumber,
    required String title,
    required String text,
    required String? question,
    required String? image,
    required String? status,
    required String? video,
    required String? backImage,
    required List<TimeOfVideo> times,
    required List<LessonFile> files,
    required List<Review> reviews,
  }) : super(
          id: id,
          title: title,
          image: image,
          moduleId: moduleId,
          text: text,
          question: question,
          video: video,
          times: times,
          files: files,
          backImage: backImage,
          lessonNumber: lessonNumber,
          status: status,
          reviews: reviews,
        );

  factory LessonDetailModel.fromJson(Map<String, dynamic> json) =>
      LessonDetailModel(
          id: json['id'] ?? 1,
          title: json['name'],
          image: json['image'],
          status: json['status'],
          moduleId: json['module'],
          text: json['text'],
          lessonNumber: json['in_module_id'],
          backImage: json['background_image'],
          video: json['video'],
          question: json['question'],
          files: (json['lessonfiles_set'] as List)
              .map((json) => LessonFile.fromJson(json))
              .toList(),
          times: (json['timer_set'] as List)
              .map((json) => TimeOfVideo.fromJson(json))
              .toList(),
          reviews: json['review'] == null 
            ? []
            : (json['review'] as List)
              .map((json) => Review.fromJson(json))
              .toList()
      );
          
}

class LessonFile {
  final int id;
  final String file;

  LessonFile({required this.id, required this.file});

  factory LessonFile.fromJson(Map<String, dynamic> json) => LessonFile(
        id: json['id'] ?? 1,
        file: json['file'],
      );
}

class TimeOfVideo {
  final int id;
  final int hour;
  final int minute;
  final int second;
  final String text;

  TimeOfVideo(
      {required this.id,
      required this.hour,
      required this.minute,
      required this.second,
      required this.text});

  factory TimeOfVideo.fromJson(Map<String, dynamic> json) => TimeOfVideo(
        id: json['id'] ?? 1,
        hour: int.parse(json['time'].split(":")[0]),
        minute: int.parse(json['time'].split(":")[1]),
        second: int.parse(json['time'].split(":")[2]),
        text: json['text'],
      );
}


class Review {
  final String text;
  List<LessonFile> files;
  final String? review;
  final DateTime dateTime;

  Review({required this.files, required this.text, required this.dateTime, required this.review});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        text: json['text'],
        files: (json['files'] as List)
              .map((json) => LessonFile.fromJson(json))
              .toList(),
        review: json['review'],
        dateTime: json['datetime'] == null 
          ? DateTime.now() 
          : DateTime.parse(json['datetime']).toLocal()
      );
}

