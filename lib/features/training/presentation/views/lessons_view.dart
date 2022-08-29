import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/training/presentation/views/training_view.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../widgets/lesson_card.dart';
import 'lesson_detail_view.dart';



class LessonsView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: Text('Модуль 1',),
        leading: BackAppbarBtn(
          onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(widget: TrainingView(courseId: 1,))),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 15.h,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, i){
                  return LessonCard(
                    onTap: (){
                      context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonDetailView()));
                      
                    },
                    isCompleted: i == 1 || i == 0,
                  );
                }
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      )
    );
  }
}