import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';

import '../../../../constants/colors/color_styles.dart';



class CourseCard extends StatelessWidget {
  final Function() onTap;
  const CourseCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(MainConfigApp.app.isSiignores) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140.h,
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(14.h)
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Уметь выдержать', style: TextStyles.cormorant_black_25_w400,),
                  Container(
                    width: 80.w,
                    height: 100.h,
                    color: ColorStyles.black,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }else{
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140.h,
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(14.h)
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text('Уметь выдержать'.toUpperCase(), style: MainConfigApp.app.isSiignores
                      ? TextStyles.cormorant_black_25_w400
                      : TextStyles.black_23_w300,),
                  ),
                  Container(
                    width: 80.w,
                    height: 100.h,
                    color: ColorStyles.black,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}