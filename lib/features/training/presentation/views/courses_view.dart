import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/widgets/loaders/loader_v1.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/training/presentation/views/training_empty_view.dart';
import 'package:siignores/features/training/presentation/views/training_view.dart';
import '../../../../core/utils/toasts.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../bloc/course/course_bloc.dart';
import '../widgets/course_card.dart';

class CoursesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CourseBloc bloc = context.read<CourseBloc>();
    if (bloc.state is CourseInitialState) {
      bloc.add(GetCoursesEvent());
    }
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseErrorState) {
          Loader.hide();
          showAlertToast(state.message);
        }

        if (state is CourseInternetErrorState) {
          context.read<AuthBloc>().add(InternetErrorEvent());
        }
      },
      builder: (context, state) {
        if (state is CourseInitialState || state is CourseLoadingState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.h,
              title: const Text(
                'Курсы',
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoaderV1(),
                SizedBox(
                  height: 75.h,
                )
              ],
            ),
          );
        }
        if (state is GotSuccessCourseState) {
          if (bloc.courses.isEmpty) {
            return MainConfigApp.app.isSiignores
                ? const TrainingEmptyView(emptyViewType: EmptyViewType.second)
                : const TrainingEmptyView(emptyViewType: EmptyViewType.first);
          }
        }
        return Scaffold(
            appBar: AppBar(
              elevation: 1.h,
              title: const Text(
                'Курсы',
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bloc.courses.length,
                        itemBuilder: (context, i) {
                          return CourseCard(
                            courseEntity: bloc.courses[i],
                            onTap: () {
                              context
                                  .read<MainScreenBloc>()
                                  .add(ChangeViewEvent(
                                      widget: TrainingView(
                                    courseId: bloc.courses[i].id,
                                  )));
                            },
                          );
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
