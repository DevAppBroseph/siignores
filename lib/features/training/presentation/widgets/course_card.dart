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
          height: 140.h,
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
          decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(14.h)),
          child: Stack(
            children: [
              Positioned(
                  bottom: 5.h,
                  right: 5.h,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: CachedImage(
                        height: 166.w,
                        alignment: Alignment.bottomRight,
                        isProfilePhoto: false,
                        fit: BoxFit.contain,
                        borderRadius: BorderRadius.zero,
                        urlImage: courseEntity.image == null
                            ? null
                            : Config.url.url + courseEntity.image!),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 200.w,
                      child: Text(
                        courseEntity.title,
                        style: TextStyles.cormorant_black_25_w400,
                      )),
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
          height: 140.h,
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 0, 0, 0),
          decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(14.h)),
          child: Stack(
            children: [
              Positioned(
                  bottom: 5.h,
                  right: 5.h,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: CachedImage(
                        height: 100.w,
                        alignment: Alignment.bottomRight,
                        isProfilePhoto: false,
                        fit: BoxFit.contain,
                        borderRadius: BorderRadius.zero,
                        urlImage: courseEntity.image == null
                            ? null
                            : Config.url.url + courseEntity.image!),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
