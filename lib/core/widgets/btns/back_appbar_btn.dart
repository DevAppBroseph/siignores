import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';

import '../../../constants/colors/color_styles.dart';




class BackAppbarBtn extends StatelessWidget {
  final Function() onTap;
  const BackAppbarBtn({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onTap,
      duration: Duration(milliseconds: 110),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SvgPicture.asset(
          'assets/svg/back_appbar.svg',
          color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
        )
      ),
    );
  }
}