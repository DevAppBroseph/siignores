part of 'test_bloc.dart';

class TestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetTestsEvent extends TestEvent{
  final int testId;
  GetTestsEvent({required this.testId});
}
class SendAnswerEvent extends TestEvent{
  final int optionId;
  SendAnswerEvent({required this.optionId});
}
class NextQuestionEvent extends TestEvent{}
