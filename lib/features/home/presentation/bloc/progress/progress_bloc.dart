import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/progress_entity.dart';
import '../../../domain/usecases/get_progress.dart';
part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final GetProgress getProgress; 
  
  ProgressBloc(this.getProgress) : super(ProgressInitialState());

  List<ProgressEntity> progressList = [];
  @override
  Stream<ProgressState> mapEventToState(ProgressEvent event) async*{
    if(event is GetProgressEvent){
      yield ProgressLoadingState();
      var offer = await getProgress(NoParams());

      yield offer.fold(
        (failure) => errorCheck(failure),
        (data){
          progressList = data;
          return GotSuccessProgressState(progress: data);
        }
      );
    }


    
  }


  ProgressState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return ProgressInternetErrorState();
    }else if(failure is ServerFailure){
      return ProgressErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return ProgressErrorState(message: 'Повторите попытку');
    }
  }

}
