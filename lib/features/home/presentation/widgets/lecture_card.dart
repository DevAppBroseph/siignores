import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/features/home/domain/entities/offer_entity.dart';

import '../../../../core/services/network/config.dart';
import '../../../../core/widgets/image/cached_image.dart';

class LectureCard extends StatelessWidget {
  final Function() onTap;
  final double width;
  final double height;
  final OfferEntity offerEntity;
  final bool isFirst;
  const LectureCard(
      {Key? key,
      required this.onTap,
      required this.width,
      required this.height,
      required this.offerEntity,
      required this.isFirst})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: 16.w, left: isFirst ? 23.w : 0),
        child: CachedImage(
          height: height,
          urlImage: offerEntity.image == null
              ? null
              : Config.url.url + offerEntity.image!,
          isProfilePhoto: null,
          borderRadius: BorderRadius.circular(18.h),
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     height: 120.h,
    //     width: 212.w,
    //     padding: EdgeInsets.symmetric(horizontal: 10.w),
    //     margin: EdgeInsets.only(right: 16.w, left: isFirst ? 23.w : 0),
    //     decoration: BoxDecoration(
    //       color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
    //       borderRadius: BorderRadius.circular(13.h)
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(MainConfigApp.app.isSiignores ? offerEntity.header : offerEntity.header.toUpperCase(), style: MainConfigApp.app.isSiignores
    //           ? TextStyles.cormorant_black_16_w400
    //           : TextStyles.black_16_w300.copyWith(color: ColorStyles.primary),),
    //         SizedBox(height: 11.h,),
    //         Text(offerEntity.description.toUpperCase(),
    //           style: MainConfigApp.app.isSiignores
    //             ? (offerEntity.description.length > 10 ? TextStyles.cormorant_black_15_w400 : TextStyles.cormorant_black_25_w400)
    //             : TextStyles.white_15_w400,
    //           textAlign: TextAlign.center,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
