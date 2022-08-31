import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/main_config_app.dart';


class LectureLoadingCard extends StatelessWidget {
  final bool isFirst;
  LectureLoadingCard({required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 212.w,
      margin: EdgeInsets.only(right: 16.w, left: isFirst ? 23.w : 0),
      decoration: BoxDecoration(
        color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.primary,
        borderRadius: BorderRadius.circular(13.h)
      ),
        
    );
  }
}