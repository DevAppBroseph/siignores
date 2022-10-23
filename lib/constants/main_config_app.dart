import 'package:flutter/material.dart';

class MainConfigApp {
  //======== APP SETTINGS ========//

  static App app = App.secondApp;

  static String telegram = MainConfigApp.app.isSiignores
      ? 'https://t.me/siignores'
      : 'https://t.me/burn_katrina';

  static String hintEmail = MainConfigApp.app.isSiignores
      ? 'mail@siignores.com'
      : 'obraztsova@mail.ru';
  static String hintFirstname =
      MainConfigApp.app.isSiignores ? 'Юлия' : 'Екатерина';
  static String hintLastname =
      MainConfigApp.app.isSiignores ? 'Бойкова' : 'Образцова';

  static List<Color> colorsOfUsers = [
    Color(0xFF0260E8),
    Color(0xFF7EB3FF),
    Color(0xFF117243),
    Color(0xFFA7E541),
    Color(0xFFFFD600),
    Color(0xFFF85C50),
    Color(0xFFFF2970),
  ];

  String? urlToCompany;
  bool isTelegram = false;

  //UI
  // static String defaultNoImage = 'assets/images/default_no_image.jpeg';
  // static String defaultNoImageUser = 'assets/images/user.png';

  static String fontFamily1 = 'Formular';
  static String fontFamily2 = 'Cormorant';
  static String fontFamily3 = 'Mak';
  static String fontFamily4 = 'Gilroy';
}

enum App { siignores, secondApp }

extension AppExtension on App {
  String get token {
    switch (this) {
      case App.siignores:
        return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWNrbmFtZSI6InNpaWdub3JlcyIsInRpbWVzdGFtcCI6IjE2NjE5NjgzOTkuNDkxNTA1MSJ9.mkne5f4wQFViqckEc9UwoJEsH8_zp-pzI4FRurtR2ik';
      case App.secondApp:
        return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWNrbmFtZSI6IklCSyIsInRpbWVzdGFtcCI6IjE2NjE5Njg2MTEuNzcyMDY5NSJ9.iItGnK-ZeikprU8YkjX4UyaUtkb-xAPMMmcV2o6zx6k';
    }
  }

  String get name {
    switch (this) {
      case App.siignores:
        return 'WOMEN’S CHANGE';
      case App.secondApp:
        return 'IBK';
    }
  }

  bool get isSiignores {
    return this == App.siignores;
  }
}
