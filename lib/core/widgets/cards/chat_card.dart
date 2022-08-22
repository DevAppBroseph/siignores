import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/colors/color_styles.dart';

import '../../../constants/texts/text_styles.dart';




class ChatCard extends StatelessWidget {
  final bool centerButton;
  final Function() onTap;
  const ChatCard({Key? key, this.centerButton = false, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17.w, 18.h, 17.w, 16.h),
      margin: EdgeInsets.symmetric(horizontal: 23.w),
      height: 105.h,
      decoration: BoxDecoration(
        color: ColorStyles.white,
        borderRadius: BorderRadius.circular(13.h)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: centerButton ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset('assets/svg/friends.svg'),
              SizedBox(width: 10.w,),
              Text('Начальная группа', style: TextStyles.black_14_w700,),
              SizedBox(width: 7.w,),
              Container(
                height: 22.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.h),
                  color: ColorStyles.greyf9f9
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text('560', style: TextStyles.green_12_w700,),
              )
            ],
          ),
          Bounce(
            duration: Duration(milliseconds: 110),
            onPressed: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorStyles.main_grey,
                borderRadius: BorderRadius.circular(26.w)
              ),
              child: Text('Перейти в чат', style: TextStyles.black_15_w700,),
            ),
          )
        ],
      ),
    );
  }
}