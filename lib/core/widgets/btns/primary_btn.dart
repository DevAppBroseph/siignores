import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';

import '../../../../constants/colors/color_styles.dart';

class PrimaryBtn extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double? width;
  const PrimaryBtn(
      {Key? key, required this.title, required this.onTap, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 110),
      onPressed: onTap,
      child: Container(
        width: width ?? 311.w,
        height: 44.h,
        decoration: BoxDecoration(
            color: ColorStyles.primary,
            borderRadius: MainConfigApp.app.isSiignores
                ? BorderRadius.circular(50.w)
                : BorderRadius.circular(8.w)),
        alignment: Alignment.center,
        child: Text(
          MainConfigApp.app.isSiignores ? title : title.toUpperCase(),
          style: MainConfigApp.app.isSiignores
              ? TextStyles.black_16_w700
              : TextStyles.black_15_w400,
        ),
      ),
    );
  }
}
