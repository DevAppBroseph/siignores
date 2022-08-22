import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/image/cached_image.dart';




class ProfilePhotoPicker extends StatelessWidget {
  final bool isVerified;
  final Color borderColor;
  final Function() onTap;
  final File? fileImage;
  final String? urlToImage;
  const ProfilePhotoPicker({Key? key, required this.isVerified, this.borderColor = ColorStyles.primary, required this.onTap, this.fileImage, this.urlToImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: 82.w,
              height: 82.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w),
                border: Border.all(width: 5.w, color: ColorStyles.white)
              ),
              child: fileImage != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(50.w),
                child: Image(
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                  image: FileImage(fileImage!),
                )
              )
              : CachedImage(
                height: MediaQuery.of(context).size.width,
                urlImage: urlToImage,
                isProfilePhoto: true,
                borderRadius: BorderRadius.circular(50.w),
              ),
            ),
          ),
          if(isVerified)
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
                borderRadius: BorderRadius.circular(50.w),
                border: Border.all(width: 4.w, color: borderColor)
              ),
              child: SvgPicture.asset('assets/svg/camera.svg',)
            )
          )
        ],
      ),
    );
  }
}