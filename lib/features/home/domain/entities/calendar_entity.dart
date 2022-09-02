import 'package:equatable/equatable.dart';

class CalendarEntity extends Equatable {
  final int id;
  final int courseId;
  final String header;
  final String description;
  final DateTime dateTime;

  CalendarEntity({
    required this.id,
    required this.header,
    required this.dateTime,
    required this.description,
    required this.courseId
  });



  @override
  List<Object> get props => [
        id,
        header,
        description,

      ];
}
