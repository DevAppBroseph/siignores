import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/services/database/auth_params.dart';
import 'package:siignores/features/auth/domain/usecases/activation_code.dart';
import 'package:siignores/features/auth/domain/usecases/register.dart';
import 'package:siignores/features/auth/domain/usecases/set_password.dart';
import 'package:siignores/features/auth/presentation/widgets/top_stage_widget.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../locator.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SetPassword setPassword;
  final ActivationCode activationCode;
  final Register register;

  RegisterBloc(this.activationCode, this.register, this.setPassword) : super(RegisterInitialState());

  CurrentStage currentStage = CurrentStage.first;
  String email = '';
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if(event is RegisterByInfoEvent){
      yield RegisterBlankState();
      var registered = await register(RegisterParams(email: event.email, firstName: event.firstName, lastName: event.lastName));
      yield registered.fold(
        (failure) => errorCheck(failure),
        (success) {
          if(success){
            email = event.email;
            currentStage = CurrentStage.second;
            return RegisterViewState();
          }
          return RegisterErrorState(message: 'Повторите попытку');
        }
        
      );
    }

    if(event is RegisterActivationCodeEvent){
      yield RegisterBlankState();
      var activated = await activationCode(ActivationCodeParams(email: email, code: event.code));
      yield activated.fold(
        (failure) => errorCheck(failure),
        (success) {
          if(success){
            currentStage = CurrentStage.third;
            return RegisterViewState();
          }
          return RegisterErrorState(message: 'Повторите попытку');
        }
        
      );
    }
    if(event is RegisterSignInEvent){
      yield RegisterBlankState();
      yield RegisterToSetPassswordViewState();
    }

    if(event is RegisterSetPasswordEvent){
      var activated = await setPassword(SetPasswordParams(email: email, password: event.password));
      yield activated.fold(
        (failure) => errorCheck(failure),
        (token) {
          if(token != null){
            currentStage = CurrentStage.first;
            sl<AuthConfig>().token = token;
            return RegisterCompletedState();
          }
          return RegisterErrorState(message: 'Повторите попытку');
        }
        
      );
    }


    if(event is RegisterBackEvent){
      yield RegisterBlankState();
      if(currentStage == CurrentStage.third){
        currentStage = CurrentStage.second;
      }else if(currentStage == CurrentStage.second){
        currentStage = CurrentStage.first;
      }
      yield RegisterViewState();
    }
  }
  



  RegisterState errorCheck(Failure failure){
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return RegisterErrorState(message: 'internet_error');
    }else if(failure is ServerFailure){
      return RegisterErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return RegisterErrorState(message: 'Повторите попытку');
    }
  }
}
