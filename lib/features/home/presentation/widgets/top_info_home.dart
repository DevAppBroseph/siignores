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
  const TopInfoHome({Key? key, required this.notificationCount, required this.onTapByName, required this.onTapNotification, required this.text, required this.urlToImage}) : super(key: key);

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
                    child: SvgPicture.asset('assets/svg/notification.svg')
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
}