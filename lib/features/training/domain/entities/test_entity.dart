import 'package:equatable/equatable.dart';
import 'package:siignores/features/training/data/models/test_model.dart';

class TestEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final bool? isExam;
  final bool isChecked;
  final List<QuestionTest> questions;

  TestEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.isExam,
    required this.isChecked,
  });

  @override
  List<Object> get props => [
        id,
        title,
      ];
}
