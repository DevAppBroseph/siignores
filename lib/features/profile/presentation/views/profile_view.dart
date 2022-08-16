import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/features/home/presentation/widgets/top_info_home.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/widgets/sections/group_section.dart';



class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorStyles.primary,
        title: Text('Профиль', style: TextStyles.black_18_w400,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  bottom: 40.h,
                  top: -100.h,
                  right: -50.w,
                  left: -50.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorStyles.primary,
                      borderRadius: const BorderRadius.all(Radius.elliptical(130, 50)),
                    ),
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h,),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            width: 82.w,
                            height: 82.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 5.w, color: ColorStyles.white)
                            ),
                            child: CachedImage(
                              height: MediaQuery.of(context).size.width,
                              urlImage: 'https://diamed.ru/wp-content/uploads/2020/11/nophoto.png',
                              isProfilePhoto: true,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: SvgPicture.asset('assets/svg/verified.svg')
                        ),
                        Positioned(
                          right: 9.w,
                          bottom: 0,
                          child: Container(
                            width: 35.w,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 35.w,
                            decoration: BoxDecoration(
                              color: ColorStyles.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 4.w, color: ColorStyles.primary)
                            ),
                            child: SvgPicture.asset('assets/svg/camera.svg',)
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Text('Юлия Бойкова', style: TextStyles.black_17_w700,),
                    SizedBox(height: 4.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('mail@siignores.com', style: TextStyles.black_14_w700,),
                        SizedBox(width: 10.w,),
                        SvgPicture.asset('assets/svg/edit.svg',)
                      ],
                    ),
                    SizedBox(height: 14.h,),
                   
                    GroupSection()

                  ],
                ),
              ],
            ),

            SizedBox(height: 35.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23.w),
                  child: Text('Мой прогресс', style: TextStyles.black_24_w700,),
                ),
                SizedBox(height: 13.h,),
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        onPressed: (){},
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}