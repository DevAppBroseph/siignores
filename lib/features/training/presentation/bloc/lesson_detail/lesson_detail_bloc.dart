import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/features/training/domain/entities/lesson_detail_entity.dart';
import 'package:siignores/features/training/domain/usecases/send_homework.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_lesson.dart';
part 'lesson_detail_event.dart';
part 'lesson_detail_state.dart';

class LessonDetailBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  final GetLesson getLesson; 
  final SendHomework sendHomework;
  
  LessonDetailBloc(this.getLesson, this.sendHomework) : super(LessonDetailInitialState());

  int selectedLessonId = 0;
  LessonDetailEntity? lesson;
  @override
  Stream<LessonDetailState> mapEventToState(LessonDetailEvent event) async*{
    if(event is GetLessonDetailEvent){
      yield LessonDetailLoadingState();
      var promos = await getLesson(event.id);

      yield promos.fold(
        (failure) => errorCheck(failure),
        (data){
          selectedLessonId = event.id;
          lesson = data;
          return GotSuccessLessonDetailState();
        }
      );
    }




    if(event is SendHomeworkEvent){
      yield LessonDetailBlankState();
      var promos = await sendHomework(SendHomeworkParams(files: event.files, text: event.text, lessonId: selectedLessonId));

      yield promos.fold(
        (failure) => errorCheck(failure),
        (data){
          return LessonDetailLoaderHideState(message: 'Успешно отправили ответ');
        }
      );
    }

    
  }


  LessonDetailState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return LessonDetailInternetErrorState();
    }else if(failure is ServerFailure){
      return LessonDetailErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return LessonDetailErrorState(message: 'Повторите попытку');
    }
  }

}
