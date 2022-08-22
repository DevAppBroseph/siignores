import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors/color_styles.dart';




class CloseModalBtn extends StatelessWidget {
  final Function() onTap;
  const CloseModalBtn({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onTap,
      duration: Duration(milliseconds: 110),
      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ColorStyles.grey_f1f1f1
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/svg/close_modal.svg'),
      ),
    );
  }
}