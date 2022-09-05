import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:siignores/constants/main_config_app.dart';

import '../../constants/colors/color_styles.dart';

void showAlertToast(String msg) {
  Fluttertoast.showToast(
      msg: '$msg',
      gravity: ToastGravity.TOP,
      backgroundColor: ColorStyles.black,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 16,);
}

void showSuccessAlertToast(String msg) {
  Fluttertoast.showToast(
      msg: '$msg',
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.TOP,
      backgroundColor: MainConfigApp.app.isSiignores ? ColorStyles.green_accent : ColorStyles.primary,
      textColor: MainConfigApp.app.isSiignores ? Colors.white : ColorStyles.black,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20,);
}