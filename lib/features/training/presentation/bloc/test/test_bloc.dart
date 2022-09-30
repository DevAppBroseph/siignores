import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/features/training/domain/entities/test_entity.dart';
import 'package:siignores/features/training/domain/usecases/complete_test.dart';
import 'package:siignores/features/training/domain/usecases/get_test.dart';
import 'package:siignores/features/training/domain/usecases/send_answer_test.dart';
import '../../../../../core/error/failures.dart';
part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final GetTest getTest;
  final SendAnswerTest sendAnswerTest;
  final CompleteTest completeTest;
  TestBloc(this.getTest, this.completeTest, this.sendAnswerTest) : super(TestInitialState());

  int indexCurrentQuestion = 0;
  TestEntity? testEntity;
  bool isCompleteTest = false;
  @override
  Stream<TestState> mapEventToState(TestEvent event) async*{
    if(event is GetTestsEvent){
      print('GET TEST BLOC: ${event.testId}');
      yield TestLoadingState();
      isCompleteTest = false;
      var promos = await getTest(event.testId);

      yield promos.fold(
        (failure) => errorCheck(failure),
        (data){
          testEntity = data;
          for(var item in data.questions){
            if(item.unanswered == true){
              indexCurrentQuestion = data.questions.indexOf(item);
              print('TRUE LENGTH: ${item.options.where((element) => element.isCorrect).length}');
              break;
            }
          }
          return GotSuccessTestState();
        }
      );
    }



    if(event is SendAnswerEvent){
      yield TestBlankState();
      if(indexCurrentQuestion == (testEntity!.questions.length-1)){
        print('TEST COMPLETE');
        isCompleteTest = true;
        var sent = await sendAnswerTest(event.optionId);
        yield sent.fold(
          (failure) => errorCheck(failure),
          (data){
            return TestBlankState();
          }
        );
        var sent2 = await completeTest(testEntity!.id);
        yield sent2.fold(
          (failure) => errorCheck(failure),
          (data){
            // if(data['all_questions'] != null && data['all_questions']! <= 30){
            //   return TestCompleteState(
            //     allQuestions: data['all_questions'] ?? 0,
            //     correctQuestions: data['your_result'] ?? 0,
            //     isExam: true
            //   );
            // }
            // return TestAnswerSendedState(isLastQuestion: true);
            return TestCompleteState(
              allQuestions: data['all_questions'] ?? 0,
              correctQuestions: data['your_result'] ?? 0,
              isExam: (testEntity!.isExam != null && testEntity!.isExam!) || (testEntity!.isExam == null && data['all_questions'] != null && data['all_questions']! <= 30)
            );
          }
        );
      }else{
        print('TEST SEND ANSWER: ${event.optionId}');
        var sent = await sendAnswerTest(event.optionId);
        yield sent.fold(
          (failure) => errorCheck(failure),
          (data){
            return TestAnswerSendedState();
          }
        );
      }
    }




    if(event is NextQuestionEvent){
      yield TestBlankState();
      indexCurrentQuestion++;
      yield TestShowState();
    }


    
  }


  TestState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return TestInternetErrorState();
    }else if(failure is ServerFailure){
      return TestErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return TestErrorState(message: 'Повторите попытку');
    }
  }

}
