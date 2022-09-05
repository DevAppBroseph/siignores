import 'package:equatable/equatable.dart';

class CalendarEntity extends Equatable {
  final int id;
  final String header;
  final String description;
  final DateTime dateTime;

  CalendarEntity({
    required this.id,
    required this.header,
    required this.dateTime,
    required this.description,
  });



  @override
  List<Object> get props => [
        id,
        header,
        description,

      ];
}
