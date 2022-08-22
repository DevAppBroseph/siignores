import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siignores/features/auth/domain/entities/reset_data_enitiy.dart';
import 'package:siignores/features/auth/domain/usecases/reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/send_code_reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/verify_code_reset_password.dart';
import 'package:siignores/features/auth/presentation/widgets/top_stage_widget.dart';
import '../../../../../core/error/failures.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ResetPassword resetPassword;
  final SendCodeResetPassword sendCodeResetPassword;
  final VerifyCodeResetPassword verifyCodeResetPassword;

  ForgotPasswordBloc(this.resetPassword, this.sendCodeResetPassword, this.verifyCodeResetPassword) : super(FPInitialState());

  CurrentStage currentStage = CurrentStage.first;
  String email = '';
  ResetDataEntity resetDataEntity = ResetDataEntity(uid: '', token: '');
  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async*{
    if(event is FPSendCodeEvent){
      yield FPBlankState();
      var registered = await sendCodeResetPassword(SendCodeResetPasswordParams(email: event.email));
      yield registered.fold(
        (failure) => errorCheck(failure),
        (success) {
          if(success){
            email = event.email;
            currentStage = CurrentStage.second;
            return FPViewState();
          }
          return FPErrorState(message: 'Повторите попытку');
        }
        
      );
    }

    if(event is FPVerifyCodeEvent){
      yield FPBlankState();
      var activated = await verifyCodeResetPassword(VerifyCodeResetPasswordParams(email: email, code: event.code));
      yield activated.fold(
        (failure) => errorCheck(failure),
        (data) {
          resetDataEntity = data;
          currentStage = CurrentStage.third;
          return FPViewState();
        }
        
      );
    }
    // if(event is ForgotPasswordSignInEvent){
    //   yield ForgotPasswordBlankState();
    //   yield ForgotPasswordToSetPassswordViewState();
    // }

    if(event is FPSetPasswordEvent){
      var activated = await resetPassword(ResetPasswordParams(
        resetDataEntity: resetDataEntity, 
        password: event.password
      ));
      yield activated.fold(
        (failure) => errorCheck(failure),
        (success) {
          if(success){
            currentStage = CurrentStage.first;
            return ForgotPasswordCompletedState();
          }
          return FPErrorState(message: 'Повторите попытку');
        }
        
      );
    }


    if(event is FPBackEvent){
      yield FPBlankState();
      if(currentStage == CurrentStage.third){
        currentStage = CurrentStage.second;
      }else if(currentStage == CurrentStage.second){
        currentStage = CurrentStage.first;
      }
      yield FPViewState();
    }
  }
  



  ForgotPasswordState errorCheck(Failure failure){
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return FPErrorState(message: 'internet_error');
    }else if(failure is ServerFailure){
      return FPErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return FPErrorState(message: 'Повторите попытку');
    }
  }
}
