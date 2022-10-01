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
class TestAnswerSendedState extends TestState{
  final bool isLastQuestion;
  TestAnswerSendedState({this.isLastQuestion = false});
}
class TestShowState extends TestState{}
class TestResultGotState extends TestState{
  final int allQuestions;
  final int correctQuestions;
  TestResultGotState({required this.allQuestions, required this.correctQuestions});
}
class TestCompleteState extends TestState{
  final int allQuestions;
  final int correctQuestions;
  final bool isExam;
  TestCompleteState({required this.allQuestions, required this.correctQuestions, required this.isExam});
}
