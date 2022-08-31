import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/training/training_repository.dart';

class SendHomework implements UseCase<bool, SendHomeworkParams> {
  final TrainingRepository repository;

  SendHomework(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendHomeworkParams params) async {
    return await repository.sendHomework(params);
  }
}

class SendHomeworkParams extends Equatable {
  final List<File> files;
  final String text;
  final int lessonId;
  SendHomeworkParams({required this.files, required this.text,  required this.lessonId});

  @override
  List<Object> get props => [files, text];
}