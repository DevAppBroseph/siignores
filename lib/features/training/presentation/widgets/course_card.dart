import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../core/services/network/config.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity courseEntity;
  final Function() onTap;
  const CourseCard({Key? key, required this.onTap, required this.courseEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MainConfigApp.app.isSiignores) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minHeight: 140.h),
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 0, 0, 0),
          decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(14.h)),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width/2.6,
                  child: CachedImage(
                    height: 140.h,
                    alignment: Alignment.bottomRight,
                    isProfilePhoto: false,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(14.h),
                      topRight: Radius.circular(14.h),
                    ),
                    fit: BoxFit.contain,
                    urlImage: courseEntity.image == null ? null : Config.url.url+courseEntity.image!
                  ),
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 22.h, bottom: 12.h),
                    width: 200.w,
                    child: Text(courseEntity.title, style: TextStyles.cormorant_black_25_w400,)
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minHeight: 140.h),
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 0, 0, 0),
          decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(14.h)),
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width/2.6,
                    child: CachedImage(
                      height: 140.h,
                      alignment: Alignment.bottomRight,
                      isProfilePhoto: false,
                      fit: BoxFit.contain,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(14.h),
                        topRight: Radius.circular(14.h),
                      ),
                      urlImage: courseEntity.image == null ? null : Config.url.url+courseEntity.image!
                    ),
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12.h, top: 22.h),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      courseEntity.title.toUpperCase(),
                      style: MainConfigApp.app.isSiignores
                          ? TextStyles.cormorant_black_25_w400
                          : TextStyles.black_23_w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
