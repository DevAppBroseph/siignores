import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import 'package:siignores/features/training/domain/usecases/get_courses.dart';

import '../../../../../core/error/failures.dart';
part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCourses getCourses; 
  
  CourseBloc(this.getCourses) : super(CourseInitialState());

  List<CourseEntity> courses = [];
  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async*{
    if(event is GetCoursesEvent){
      yield CourseLoadingState();
      var promos = await getCourses(NoParams());

      yield promos.fold(
        (failure) => errorCheck(failure),
        (data){
          courses = data;
          return GotSuccessCourseState();
        }
      );
    }


    
  }


  CourseState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return CourseInternetErrorState();
    }else if(failure is ServerFailure){
      return CourseErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return CourseErrorState(message: 'Повторите попытку');
    }
  }

}
