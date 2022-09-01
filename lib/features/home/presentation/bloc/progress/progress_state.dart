part of 'progress_bloc.dart';

class ProgressState extends Equatable {
  const ProgressState();
  @override
  List<Object> get props => [];
}

class ProgressInitialState extends ProgressState {}
class ProgressLoadingState extends ProgressState {}
class ProgressErrorState extends ProgressState {
  final String message;
  ProgressErrorState({required this.message});
}
class ProgressInternetErrorState extends ProgressState{}

class GotSuccessProgressState extends ProgressState{}
