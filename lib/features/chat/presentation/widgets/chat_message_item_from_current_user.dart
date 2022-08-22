import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/widgets/image/cached_image.dart';


class ChatMessageItemFromCurrentUser extends StatelessWidget {
  const ChatMessageItemFromCurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 50.w, maxWidth: 248.w),
                decoration: BoxDecoration(
                  color: ColorStyles.primary,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Text('Ковальчук Виталий', style: TextStyles.black_14_w700,),
              ),
              SizedBox(width: 16.w,),
              SizedBox(
                width: 34.w,
                child: CachedImage(
                  height: 34.w,
                  borderRadius: BorderRadius.circular(34.w),
                  urlImage: 'https://aikidojo.lv/wp-content/uploads/2019/08/nophoto.jpg',
                  isProfilePhoto: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('2:37', style: TextStyles.black_11_w400
                .copyWith(color: ColorStyles.black.withOpacity(0.7)),),
              SizedBox(width: 50.w,),
            ],
          )
        ],
      ),
    );
  }
}