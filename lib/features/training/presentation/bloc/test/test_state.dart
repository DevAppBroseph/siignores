part of 'test_bloc.dart';

class TestState extends Equatable {
  const TestState();
  @override
  List<Object> get props => [];
}

class TestInitialState extends TestState {}
class TestLoadingState extends TestState {}
class TestErrorState extends TestState {
  final String message;
  TestErrorState({required this.message});
}
class TestInternetErrorState extends TestState{}

class GotSuccessTestState extends TestState{}
class TestBlankState extends TestState{}
class TestShowState extends TestState{
  final bool isLastQuestion;
  TestShowState({this.isLastQuestion = false});
}
class TestCompleteState extends TestState{
  final int allQuestions;
  final int correctQuestions;
  TestCompleteState({required this.allQuestions, required this.correctQuestions});
}
