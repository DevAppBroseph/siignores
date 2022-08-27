import 'package:flutter/material.dart';
import 'package:siignores/constants/main_config_app.dart';
const Map<int, Color> color =
{
  50:Color.fromRGBO(212, 203, 196, .1),
  100:Color.fromRGBO(212, 203, 196, .2),
  200:Color.fromRGBO(212, 203, 196, .3),
  300:Color.fromRGBO(212, 203, 196, .4),
  400:Color.fromRGBO(212, 203, 196, .5),
  500:Color.fromRGBO(212, 203, 196, .6),
  600:Color.fromRGBO(212, 203, 196, .7),
  700:Color.fromRGBO(212, 203, 196, .8),
  800:Color.fromRGBO(212, 203, 196, .9),
  900:Color.fromRGBO(212, 203, 196, 1),
};
const Map<int, Color> color2 =
{
  50:Color.fromRGBO(244, 205, 123, .1),
  100:Color.fromRGBO(244, 205, 123, .2),
  200:Color.fromRGBO(244, 205, 123, .3),
  300:Color.fromRGBO(244, 205, 123, .4),
  400:Color.fromRGBO(244, 205, 123, .5),
  500:Color.fromRGBO(244, 205, 123, .6),
  600:Color.fromRGBO(244, 205, 123, .7),
  700:Color.fromRGBO(244, 205, 123, .8),
  800:Color.fromRGBO(244, 205, 123, .9),
  900:Color.fromRGBO(244, 205, 123, 1),
};
class ColorStyles {
  static Color primary = MainConfigApp.app.isSiignores ? Color(0xFFD4CBC4) : Color(0xFFF4CD7B);
  static MaterialColor primarySwath = MainConfigApp.app.isSiignores ? MaterialColor(0xFFD4CBC4, color) : MaterialColor(0xFFF4CD7B, color2);

  static const black = Color(0xFF323232);
  static const black2 = Color.fromRGBO(38, 38, 38, 1);
  static const white = Color(0xFFFFFFFF);
  static const white2 = Color(0xFFF4F4F4);
  static const telegram = Color(0xFF40B3E0);
  static const text_color = Color(0xFF705B4C);



  static const greyf9f9 = Color(0xFFF9F9F9);
  static const grey888 = Color(0xFF888888);
  static const grey999 = Color(0xFF999999);
  static const grey777 = Color(0xFF777777);
  static const grey929292 = Color(0xFF929292);
  static const grey_f1f1f1 = Color(0xFFF1F1F1);

  static const green_accent = Color(0xFF6DB533);
  static const lilac = Color(0xFFDDC6E0);
  static const lilac2 = Color(0xFFEFEAEF);
  static const darkViolet = Color(0xFFB799BB);

  static Color backgroundColor = MainConfigApp.app.isSiignores ? Color(0xFFF0EEEC) : Color(0xFF1C1B1B);

  
}