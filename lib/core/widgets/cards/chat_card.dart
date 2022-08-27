import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';

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
        color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
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
              SvgPicture.asset(
                'assets/svg/friends.svg',
                color: MainConfigApp.app.isSiignores ? null : ColorStyles.lilac,
              ),
              SizedBox(width: 10.w,),
              Text('Начальная группа', style: MainConfigApp.app.isSiignores
                ? TextStyles.black_14_w700
                : TextStyles.white_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
              SizedBox(width: 7.w,),
              Container(
                height: 22.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.h),
                  color: MainConfigApp.app.isSiignores ? ColorStyles.greyf9f9 : ColorStyles.white
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text('560', style: MainConfigApp.app.isSiignores
                  ? TextStyles.green_12_w700
                  : TextStyles.black_12_w700.copyWith(fontFamily: MainConfigApp.fontFamily4),),
              )
            ],
          ),
          Bounce(
            duration: Duration(milliseconds: 110),
            onPressed: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.primary,
                borderRadius: BorderRadius.circular(MainConfigApp.app.isSiignores ? 26.w : 8.w)
              ),
              child: Text(MainConfigApp.app.isSiignores 
                ? 'Перейти в чат' 
                : 'Перейти в чат'.toUpperCase(), 
                style: MainConfigApp.app.isSiignores
                ? TextStyles.black_15_w700
                : TextStyles.black_14_w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}