import 'package:intl/intl.dart';

import '../../domain/entities/calendar_entity.dart';

class CalendarModel extends CalendarEntity{
  CalendarModel({
    required int id,
    required String header,
    required String description,
    required bool nonCycle,
    required String period,
    required DateTime dateTime,

  }) : super(
    id: id, 
    header: header,
    dateTime: dateTime,
    description: description,
    nonCycle: nonCycle,
    period: period,
  );

  factory CalendarModel.fromJson(Map<String, dynamic> json){
    return CalendarModel(
      id: json['id'] ?? 1,
      header: json['header'],
      description: json['description'],
      dateTime: DateFormat("yyyy-MM-dd HH:mm:ss").parse('${json['date']} ${json['time']}', true).toLocal(),//DateTime.parse('${json['date']} ${json['time']}').toLocal(),
      period: json['period'],
      nonCycle: json['non_cycle']
    );
  }
}