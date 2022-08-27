import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/main_config_app.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';



class LectureCard extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String text;
  final bool isFirst;
  const LectureCard({Key? key, required this.onTap, required this.text, required this.title, required this.isFirst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.h,
        width: 212.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        margin: EdgeInsets.only(right: 16.w, left: isFirst ? 23.w : 0),
        decoration: BoxDecoration(
          color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
          borderRadius: BorderRadius.circular(13.h)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(MainConfigApp.app.isSiignores ? title : title.toUpperCase(), style: MainConfigApp.app.isSiignores
              ? TextStyles.cormorant_black_16_w400
              : TextStyles.black_16_w300.copyWith(color: ColorStyles.primary),),
            SizedBox(height: 11.h,),
            Text(text.toUpperCase(), 
              style: MainConfigApp.app.isSiignores
                ? (text.length > 10 ? TextStyles.cormorant_black_15_w400 : TextStyles.cormorant_black_25_w400)
                : TextStyles.white_15_w400,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}