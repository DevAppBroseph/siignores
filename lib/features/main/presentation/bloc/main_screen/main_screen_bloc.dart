import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  
  MainScreenBloc() : super(MainScreenChangedState(currentView: 0, currentWidget: null));

  int currentView = 0;
  Widget? currentWidget = null;

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async*{
    
    if(event is ChangeViewEvent){
      yield MainScreenBlankState();
      if(event.view != null){
        currentView = event.view!;
        currentWidget = null;
      }else{
        currentWidget = event.widget;
      }
      yield MainScreenChangedState(currentView: currentView, currentWidget: currentWidget);
    }

    if(event is SetStateEvent){
        yield MainScreenBlankState();
        yield MainScreenSetStateState();
    }
  }
}
