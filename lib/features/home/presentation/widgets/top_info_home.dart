import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/widgets/image/cached_image.dart';



class TopInfoHome extends StatelessWidget {
  final String text;
  final String? urlToImage;
  final int notificationCount;
  final Function() onTapByName;
  final Function() onTapNotification;
  TopInfoHome({Key? key, required this.notificationCount, required this.onTapByName, required this.onTapNotification, required this.text, required this.urlToImage}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapByName,
            child: Container(
              padding: EdgeInsets.fromLTRB(5.h, 5.h, 18.h, 5.h),
              decoration: BoxDecoration(
                border: Border.all(color: ColorStyles.white, width: 2.w),
                borderRadius: BorderRadius.circular(30.h)
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 33.h,
                    child: CachedImage(
                      borderRadius: BorderRadius.circular(30),
                      height: 33.h, 
                      urlImage: urlToImage, 
                      isProfilePhoto: true
                    ),
                  ),
                  SizedBox(width: 7.w,),
                  Text(text, style: TextStyles.black_16_w700,)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapNotification,
            child: Container(
              height: 35.h,
              width: 32.h,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CustomPopupMenu(
                      arrowColor: ColorStyles.white,
                      arrowSize: 20,
                      showArrow: true,
                      child: SvgPicture.asset('assets/svg/notification.svg'),
                      menuBuilder: _buildLongPressMenu,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pressType: PressType.singleClick,
                      
                    )
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 17.w,
                      height: 17.w,
                      decoration: BoxDecoration(
                        color: ColorStyles.green_accent,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      alignment: Alignment.center,
                      child: Text('$notificationCount', style: TextStyles.white_11_w700,),
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }




  Widget _buildLongPressMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.h),
      child: Container(
        width: 330.w,
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        color: ColorStyles.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 26.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Для Вас новое предложение', style: TextStyles.black_15_w500,),
                  SizedBox(height: 4.h,),
                  Text('4 ч. назад', style: TextStyles.black_13_w400
                    .copyWith(color: ColorStyles.black.withOpacity(0.5)),)
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 1.h,
              color: ColorStyles.black.withOpacity(0.15),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 26.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Для Вас новое предложение', style: TextStyles.black_15_w500,),
                  SizedBox(height: 4.h,),
                  Text('4 ч. назад', style: TextStyles.black_13_w400
                    .copyWith(color: ColorStyles.black.withOpacity(0.5)),)
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 1.h,
              color: ColorStyles.black.withOpacity(0.15),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 26.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Для Вас новое предложение', style: TextStyles.black_15_w500,),
                  SizedBox(height: 4.h,),
                  Text('4 ч. назад', style: TextStyles.black_13_w400
                    .copyWith(color: ColorStyles.black.withOpacity(0.5)),)
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}