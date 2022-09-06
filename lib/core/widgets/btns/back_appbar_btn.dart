import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';

import '../../../constants/colors/color_styles.dart';

class BackAppbarBtn extends StatelessWidget {
  final Function() onTap;
  final bool black;
  const BackAppbarBtn({Key? key, required this.onTap, this.black = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          child: SvgPicture.asset(
            'assets/svg/back_appbar.svg',
            color: black
                ? ColorStyles.black
                : (MainConfigApp.app.isSiignores ? null : ColorStyles.white),
          )),
    );
  }
}
