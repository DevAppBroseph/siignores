import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/training/domain/entities/module_enitiy.dart';
import 'package:siignores/features/training/presentation/views/training_view.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../bloc/lessons/lessons_bloc.dart';
import '../widgets/lesson_card.dart';
import 'lesson_detail_view.dart';

class LessonsView extends StatelessWidget {
  final ModuleEntity moduleEntity;
  final int courseId;
  const LessonsView(
      {Key? key, required this.moduleEntity, required this.courseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonsBloc bloc = context.read<LessonsBloc>();
    if (bloc.selectedModuleId != moduleEntity.id) {
      bloc.add(GetLessonsEvent(id: moduleEntity.id));
    }
    return Scaffold(
        appBar: AppBar(
            elevation: 1.h,
            title: Text(moduleEntity.title),
            leading: BackAppbarBtn(
              onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(
                      widget: TrainingView(
                    courseId: courseId,
                  ))),
            )),
        body: BlocConsumer<LessonsBloc, LessonsState>(
          listener: (context, state) {
            if (state is LessonsErrorState) {
              Loader.hide();
              showAlertToast(state.message);
            }

            if (state is LessonsInternetErrorState) {
              context.read<AuthBloc>().add(InternetErrorEvent());
            }
          },
          builder: (context, state) {
            if (state is LessonsInitialState || state is LessonsLoadingState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoaderV1(),
                  SizedBox(
                    height: 75.h,
                  )
                ],
              );
            }
            if (state is GotSuccessLessonsState) {
              if (bloc.lessons.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Пока нет уроков',
                      style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_15_w700
                          : TextStyles.white_15_w400
                              .copyWith(fontFamily: MainConfigApp.fontFamily4),
                    ),
                    SizedBox(
                      height: 75.h,
                      width: MediaQuery.of(context).size.width,
                    )
                  ],
                );
              }
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bloc.lessons.length,
                        itemBuilder: (context, i) {
                          return LessonCard(
                              lessonListEntity: bloc.lessons[i],
                              onTap: () {
                                context
                                    .read<MainScreenBloc>()
                                    .add(ChangeViewEvent(
                                        widget: LessonDetailView(
                                      courseId: courseId,
                                      lessonId: bloc.lessons[i].id,
                                      moduleEntity: moduleEntity,
                                    )));
                              },
                              isCompleted: false);
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
