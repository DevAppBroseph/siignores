import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/core/widgets/modals/test_complete_modal.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/training/domain/entities/module_enitiy.dart';
import 'package:siignores/features/training/presentation/bloc/test/test_bloc.dart';
import 'package:siignores/features/training/presentation/views/lessons_view.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../data/models/test_model.dart';



class TestView extends StatefulWidget {
  final ModuleEntity moduleEntity;
  final int courseId;
  final int testId;
  TestView({required this.moduleEntity, required this.testId, required this.courseId});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {

  int? selectedAnswer;
  String title = '';

  void sendAnswer(){
    if(selectedAnswer != null && !(context.read<TestBloc>().state is TestInitialState || context.read<TestBloc>().state is TestLoadingState)){
      showLoaderWrapper(context);
      context.read<TestBloc>().add(SendAnswerEvent(optionId: selectedAnswer!));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TestBloc>().add(GetTestsEvent(testId: widget.testId));
  }

  @override
  Widget build(BuildContext context) {
    TestBloc bloc = context.read<TestBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: Text(title),
        leading: BackAppbarBtn(
          onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonsView(moduleEntity: widget.moduleEntity, courseId: widget.courseId,))),
        )
      ),
      body: BlocConsumer<TestBloc, TestState>(
        listener: (context, state) async {
          if(state is TestShowState){
            Loader.hide();
            setState(() {
              selectedAnswer = null;
            });
          }
          if(state is TestAnswerSendedState){
            Loader.hide();
            if(state.isLastQuestion){
              context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonsView(moduleEntity: widget.moduleEntity, courseId: widget.courseId,)));
            }
          }
          if(state is TestCompleteState){
            Loader.hide();
            await TestCompleteModal(context: context, allQuestions: state.allQuestions, correctQuestions: state.correctQuestions).showMyDialog();
            context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonsView(moduleEntity: widget.moduleEntity, courseId: widget.courseId,)));
          }
          if(state is TestErrorState){
            Loader.hide();
            showAlertToast(state.message);
          }

          if(state is TestInternetErrorState){
            context.read<AuthBloc>().add(InternetErrorEvent());
          }
          if(state is GotSuccessTestState){
            if(bloc.testEntity != null){
              setState(() {
                title = bloc.testEntity!.title;
              });
            }
          }
        },
        builder: (context, state){
          if(state is TestInitialState || state is TestLoadingState){
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoaderV1(),
                SizedBox(height: 75.h,)
              ],
            );
          }
          if(state is GotSuccessTestState){
            if(bloc.testEntity == null){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Не смогли открыть тест!', style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_15_w700
                    : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                  SizedBox(height: 75.h, width: MediaQuery.of(context).size.width,)
                ],
              );
            }
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 25.h, width: MediaQuery.of(context).size.width,),
                  Text.rich(
                    TextSpan(
                        text: 'Вопрос: ',
                        style: MainConfigApp.app.isSiignores
                          ? TextStyles.white_16_w400.copyWith(color: ColorStyles.black.withOpacity(0.6))
                          : TextStyles.white_16_w400.copyWith(
                            color: ColorStyles.white.withOpacity(0.6),
                            fontFamily: MainConfigApp.fontFamily4,
                          ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '${bloc.indexCurrentQuestion+1}/',
                            style: MainConfigApp.app.isSiignores
                              ? TextStyles.black_16_w700
                              : TextStyles.white_16_w700.copyWith(fontFamily: MainConfigApp.fontFamily4),
                          ),
                          TextSpan(
                            text: '${bloc.testEntity == null ? 0 : bloc.testEntity!.questions.length}',
                            style: MainConfigApp.app.isSiignores
                              ? TextStyles.white_16_w400.copyWith(color: ColorStyles.black.withOpacity(0.6))
                              : TextStyles.white_16_w400.copyWith(
                                color: ColorStyles.white.withOpacity(0.6),
                                fontFamily: MainConfigApp.fontFamily4,
                              ),
                          )
                        ]),
                  ),
                  
                  SizedBox(height: 70.h,),
                  Text(bloc.testEntity!.questions[bloc.indexCurrentQuestion].title, style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_16_w400
                    : TextStyles.white_16_w400.copyWith(
                      fontFamily: MainConfigApp.fontFamily4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 60.h,),
                  Container(
                    width: 311.w,
                    decoration: BoxDecoration(
                      color: ColorStyles.white,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: Column(
                      children: bloc.testEntity!.questions[bloc.indexCurrentQuestion].options.map((option) 
                        => bloc.testEntity!.questions.length <= 30 
                          ? _buildAnwerItemExam(context, option)
                          : _buildAnwerItem(context, option)
                      ).toList()
                    ),
                  ),
                  SizedBox(height: 250.h,),

                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PrimaryBtn(
            title: 'ДАЛЬШЕ',
            onTap: (){
              if(selectedAnswer != null){
                context.read<TestBloc>().add(NextQuestionEvent());
              }
            }
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAnwerItem(BuildContext context, OptionTest optionTest){
    TestBloc bloc = context.read<TestBloc>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        if(selectedAnswer == null){
          setState(() {
            selectedAnswer = optionTest.id;
            sendAnswer();
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: BoxDecoration(
                      color: selectedAnswer != null && !bloc.testEntity!.questions[bloc.indexCurrentQuestion].options.any((element) => element.isCorrect && element.id == selectedAnswer)
                        ? (!optionTest.isCorrect ? Colors.red : ColorStyles.green_accent) 
                        : selectedAnswer != null && selectedAnswer == optionTest.id
                        ? ColorStyles.primary
                        : null,
                      border: Border.all(
                        color: selectedAnswer != null && !bloc.testEntity!.questions[bloc.indexCurrentQuestion].options.any((element) => element.isCorrect && element.id == selectedAnswer)
                        ? (!optionTest.isCorrect ? Colors.red : ColorStyles.green_accent) 
                        : ColorStyles.primary, 
                        width: 2.h,
                      ),
                      borderRadius: BorderRadius.circular(30.h)
                    ),
                    alignment: Alignment.center,
                    child: selectedAnswer != null
                    ? Icon(
                      !optionTest.isCorrect ? Icons.close : Icons.check,
                      color: ColorStyles.white,
                      size: 15.w,
                    ) : null,
                  ),
                  SizedBox(width: 8.w,),
                  Flexible(child: Text(optionTest.text, style: TextStyles.black_14_w700,))
                ],
              ),
            ),
            false && selectedAnswer != null && !bloc.testEntity!.questions[bloc.indexCurrentQuestion].options.any((element) => element.isCorrect && element.id == selectedAnswer)
            ? Row(
              children: [
                Icon(
                  Icons.person,
                  color: !optionTest.isCorrect ? Colors.red : ColorStyles.green_accent,
                  size: 20.w,
                ),
                SizedBox(width: 4.w,),
                Text(!optionTest.isCorrect ? '20%' : '80%', style: TextStyles.black_12_w700
                .copyWith(color: !optionTest.isCorrect ? Colors.red : ColorStyles.green_accent),)
              ],
            ) : SizedBox.shrink(),
          ],
        ),
      ),
    );
    
  }




  Widget _buildAnwerItemExam(BuildContext context, OptionTest optionTest){
    TestBloc bloc = context.read<TestBloc>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        if(selectedAnswer == null){
          setState(() {
            selectedAnswer = optionTest.id;
            sendAnswer();
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 14.w),
        margin: EdgeInsets.symmetric(vertical: 15.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bloc.testEntity!.questions[bloc.indexCurrentQuestion].options.any((element) => !element.isCorrect && element.id == selectedAnswer) 
            ? (selectedAnswer == optionTest.id && !optionTest.isCorrect 
              ? ColorStyles.red 
              : optionTest.isCorrect 
              ? ColorStyles.green_accent
              : ColorStyles.grey_f1f1f1)
            : optionTest.id == selectedAnswer
            ? ColorStyles.green_accent
            : ColorStyles.grey_f1f1f1,
          borderRadius: BorderRadius.circular(12.w)
        ),
        child: Text(optionTest.text, style: TextStyles.black_14_w700
          .copyWith(color: bloc.testEntity!.questions[bloc.indexCurrentQuestion].options
            .any((element) => !element.isCorrect && element.id == selectedAnswer) && selectedAnswer == optionTest.id && !optionTest.isCorrect 
            ? ColorStyles.white
            : ColorStyles.black),)
      ),
    );
    
  }
}