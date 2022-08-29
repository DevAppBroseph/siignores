import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import 'package:siignores/features/training/domain/entities/module_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_modules.dart';
part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final GetModules getModules; 
  
  ModuleBloc(this.getModules) : super(ModuleInitialState());

  int selectedCourseId = 0;
  List<ModuleEntity> modules = [];
  @override
  Stream<ModuleState> mapEventToState(ModuleEvent event) async*{
    if(event is GetModulesEvent){
      print('ID: ${event.id}');
      yield ModuleLoadingState();
      var promos = await getModules(event.id);

      yield promos.fold(
        (failure) => errorCheck(failure),
        (data){
          selectedCourseId = event.id;
          modules = data;
          return GotSuccessModuleState();
        }
      );
    }


    
  }


  ModuleState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return ModuleInternetErrorState();
    }else if(failure is ServerFailure){
      return ModuleErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return ModuleErrorState(message: 'Повторите попытку');
    }
  }

}
