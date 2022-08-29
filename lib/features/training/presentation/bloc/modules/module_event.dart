part of '../modules/module_bloc.dart';

class ModuleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetModulesEvent extends ModuleEvent{
  final int id;
  GetModulesEvent({required this.id});
}

