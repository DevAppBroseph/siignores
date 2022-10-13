

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors/color_styles.dart';

class TopMessageDialog{
  showDialog(BuildContext context, {String? title, required message, required Function() onTap}){
    Flushbar(
      title:  title,
      message:  message,
      duration:  Duration(seconds: 4),
      titleColor: ColorStyles.black,
      messageColor: ColorStyles.black,
      flushbarPosition: FlushbarPosition.TOP,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      flushbarStyle: FlushbarStyle.FLOATING,
      onTap: (_) {onTap();},
      maxWidth: MediaQuery.of(context).size.width*0.95,
      backgroundColor: ColorStyles.white,
      borderRadius: BorderRadius.circular(10.h),
      boxShadows: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4
        )
      ],
    ).show(context);
  }
}