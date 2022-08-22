import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/features/training/presentation/views/lessons_view.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../widgets/module_card.dart';



class TrainingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: ColorStyles.black,
        title: Text('Тренинг', style: TextStyles.title_app_bar,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(height: 15.h,),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.15
                ), 
                itemBuilder: (context, i){
                  return ModuleCard(
                    onTap: (){
                      context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonsView()));
                    },
                  );
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}