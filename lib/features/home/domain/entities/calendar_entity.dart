import 'package:equatable/equatable.dart';

class CalendarEntity extends Equatable {
  final int id;
  final String header;
  final String description;
  DateTime dateTime;
  final bool nonCycle;
  final String period;

  CalendarEntity({
    required this.id,
    required this.header,
    required this.dateTime,
    required this.description,
    required this.nonCycle,
    required this.period,
  });



  @override
  List<Object> get props => [
        id,
        header,
        description,
        nonCycle,
        period
      ];
}
