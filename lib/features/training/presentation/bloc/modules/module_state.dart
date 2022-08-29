part of '../modules/module_bloc.dart';

class ModuleState extends Equatable {
  const ModuleState();
  @override
  List<Object> get props => [];
}

class ModuleInitialState extends ModuleState {}
class ModuleLoadingState extends ModuleState {}
class ModuleErrorState extends ModuleState {
  final String message;
  ModuleErrorState({required this.message});
}
class ModuleInternetErrorState extends ModuleState{}

class GotSuccessModuleState extends ModuleState{}
