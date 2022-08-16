import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';

import '../../../../constants/colors/color_styles.dart';
import '../widgets/lesson_card.dart';



class LessonsView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: ColorStyles.black,
        title: Text('Модуль 1', style: TextStyles.title_app_bar,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
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