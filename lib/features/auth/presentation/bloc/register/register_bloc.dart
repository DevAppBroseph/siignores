import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/features/auth/presentation/widgets/top_stage_widget.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  RegisterBloc() : super(RegisterInitialState());

  CurrentStage currentStage = CurrentStage.first;
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    print('EVENT: ${event}');
    if(event is RegisterSendCodeOTPEvent){
      yield RegisterBlankState();
      currentStage = CurrentStage.second;
      yield RegisterViewState();
    }
    if(event is RegisterUserByOTPEvent){
      yield RegisterBlankState();
      currentStage = CurrentStage.third;
      yield RegisterViewState();
    }
    if(event is RegisterSignInEvent){
      yield RegisterBlankState();
      currentStage = CurrentStage.first;
      yield RegisterViewState();
    }
  }
}
