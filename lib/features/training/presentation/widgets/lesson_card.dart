import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/helpers/lesson_helper.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../core/services/network/config.dart';
import '../../../../core/widgets/image/cached_image.dart';



class LessonCard extends StatelessWidget {
  final Function() onTap;
  final bool isCompleted;
  final LessonListEntity lessonListEntity;
  const LessonCard({Key? key, required this.onTap, required this.isCompleted, required this.lessonListEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(MainConfigApp.app.isSiignores) {
      return GestureDetector(
        onTap: (){
          if(lessonListEntity.isOpen){
            onTap();
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
          constraints: BoxConstraints(minHeight: 140.h),
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(14.h)
          ),
          
          child: Stack(
            children: [
              Positioned(
                bottom: 5.h,
                right: 5.h,
                child: Container(
                  width: MediaQuery.of(context).size.width/3.5,
                  child: CachedImage(
                    height: 100.w,
                    isProfilePhoto: false,
                    alignment: Alignment.bottomRight,
                    fit: BoxFit.contain,
                    borderRadius: BorderRadius.zero,
                    urlImage: lessonListEntity.image == null ? null : Config.url.url+lessonListEntity.image!
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(lessonListEntity.title.toUpperCase(), style: TextStyles.cormorant_black_18_w400,)
                      ),
                      SizedBox(width: 10.h,),
                      getStatusWidget(lessonListEntity),
                      SizedBox(width: 10.h,),
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text(lessonListEntity.miniDesc, style: TextStyles.cormorant_black_25_w400,),
                  ),
                  SizedBox(height: 8.h,),
                  isCompleted
                  ? Container(
                    padding: EdgeInsets.fromLTRB(14.w, 7.h, 20.w, 7.h),
                    decoration: BoxDecoration(
                      color: ColorStyles.green_accent,
                      borderRadius: BorderRadius.circular(18.w)
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/checked_white.svg'),
                        SizedBox(width: 9.w,),
                        Text('Урок пройден', style: TextStyles.white_11_w700,)
                      ],
                    ),
                  ) : SizedBox.shrink()
                ],
              ),
              if(!lessonListEntity.isOpen)
              Positioned( 
                top: 15.h,
                right: 15.w,
                child: Image.asset(
                  'assets/images/lock.png',
                  width: 20.w,
                ) 
              )  
            ],
          ),
        ),
      );
    }else{
      return GestureDetector(
        onTap: (){
          if(lessonListEntity.isOpen){
            onTap();
          }
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(minHeight: 140.h),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 14.h),
              padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
              decoration: BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.circular(14.h)
              ),
              
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5.h,
                    right: 5.h,
                    child: Container(
                      width: MediaQuery.of(context).size.width/3.5,
                      child: CachedImage(
                        height: 100.w,
                        isProfilePhoto: false,
                        alignment: Alignment.bottomRight,
                        fit: BoxFit.contain,
                        borderRadius: BorderRadius.zero,
                        urlImage: lessonListEntity.image == null ? null : Config.url.url+lessonListEntity.image!
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Text(lessonListEntity.title.toUpperCase(), style: TextStyles.black_15_w300,)
                          ),
                          SizedBox(width: 10.h,),
                          getStatusWidget(lessonListEntity),

                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(lessonListEntity.miniDesc, style: TextStyles.black_20_w300,),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                ],
              ),
            ),

            if(isCompleted)
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset('assets/svg/completed_lesson.svg'),
            ),
            if(!lessonListEntity.isOpen)
            Positioned( 
              top: 15.h,
              right: 15.w,
              child: Image.asset(
                'assets/images/lock.png',
                width: 20.w,
              ) 
            )            
          ],
        ),
      );
    }
  }
}