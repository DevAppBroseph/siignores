import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';

import '../../../../constants/colors/color_styles.dart';



class LessonCard extends StatelessWidget {
  final Function() onTap;
  final bool isCompleted;
  const LessonCard({Key? key, required this.onTap, required this.isCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Text('Урок 1 '.toUpperCase(), style: TextStyles.cormorant_black_18_w400,),
            SizedBox(height: 5.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Уметь выдержать', style: TextStyles.cormorant_black_25_w400,),
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
                Container(
                  width: 40.w,
                  height: 70.h,
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