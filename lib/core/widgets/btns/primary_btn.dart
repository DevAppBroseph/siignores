import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';

import '../../../../constants/colors/color_styles.dart';

class PrimaryBtn extends StatelessWidget {
  final String title;
  final Function() onTap;
  const PrimaryBtn({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: onTap,
      child: Container(
        width: 311.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: ColorStyles.primary,
          borderRadius: BorderRadius.circular(50)
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyles.black_16_w700,),
      ),
    );
  }
}
