import '../../domain/entities/calendar_entity.dart';

class CalendarModel extends CalendarEntity{
  CalendarModel({
    required int id,
    required String header,
    required String description,
    required DateTime dateTime,

  }) : super(
    id: id, 
    header: header,
    dateTime: dateTime,
    description: description,
  );

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
    id: json['id'] ?? 1,
    header: json['header'],
    description: json['description'],
    dateTime: DateTime.parse('${json['date']} ${json['time']}').toLocal()
    
  );
}