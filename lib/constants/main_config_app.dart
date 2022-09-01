class MainConfigApp {
  //======== APP SETTINGS ========//

  static App app = App.siignores;

  static String telegram = MainConfigApp.app.isSiignores ? 'https://t.me/siignores' : 'https://t.me/burn_katrina';

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

  bool get isSiignores {
    return this == App.siignores;
  }
}
