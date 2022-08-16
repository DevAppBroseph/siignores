import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/colors/color_styles.dart';

void showAlertToast(String msg) {
  Fluttertoast.showToast(
      msg: '$msg',
      gravity: ToastGravity.TOP,
      backgroundColor: ColorStyles.black,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 16,);
}

void showSuccessAlertToast(String msg) {
  Fluttertoast.showToast(
      msg: '$msg',
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.TOP,
      backgroundColor: ColorStyles.green_accent,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 20,);
}