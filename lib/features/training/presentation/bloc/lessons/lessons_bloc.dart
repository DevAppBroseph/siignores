import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_lessons.dart';
part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  final GetLessons getLessons;

  LessonsBloc(
    this.getLessons,
  ) : super(LessonsInitialState());

  int selectedModuleId = 0;
  List<LessonListEntity> lessons = [];
  @override
  Stream<LessonsState> mapEventToState(LessonsEvent event) async* {
    if (event is GetLessonsEvent) {
      yield LessonsLoadingState();
      var promos = await getLessons(event.id);

      yield promos.fold((failure) => errorCheck(failure), (data) {
        selectedModuleId = event.id;
        lessons.clear();
        for (var i = 0; i < data.length; i++) {
          if (i == 0) {
            data[i].isOpen = true;
          } else {
            if (data[i - 1].status == 'complete' ||
                data[i].status == 'complete' ||
                data[i - 1].question != 'null' &&
                    data[i - 1].question != null &&
                    data[i - 1].question == '' &&
                    !lessons.any((element) => element.isOpen == false)) {
              data[i].isOpen = true;
            } else {
              data[i].isOpen = false;
            }
          }

          lessons.add(data[i]);
        }
        return GotSuccessLessonsState();
      });
    }
  }

  LessonsState errorCheck(Failure failure) {
    print('FAIL: ${failure}');
    if (failure == ConnectionFailure() || failure == NetworkFailure()) {
      return LessonsInternetErrorState();
    } else if (failure is ServerFailure) {
      return LessonsErrorState(
          message: failure.message.length < 100
              ? failure.message
              : 'Ошибка сервера');
    } else {
      return LessonsErrorState(message: 'Повторите попытку');
    }
  }
}
