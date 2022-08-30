import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/features/training/domain/entities/lesson_detail_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_lesson.dart';
part 'lesson_detail_event.dart';
part 'lesson_detail_state.dart';

class LessonDetailBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  final GetLesson getLesson; 
  
  LessonDetailBloc(this.getLesson,) : super(LessonDetailInitialState());

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
