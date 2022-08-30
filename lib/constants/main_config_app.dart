


class MainConfigApp {

  //======== APP SETTINGS ========//

  static App app = App.siignores; 


  //UI
  // static String defaultNoImage = 'assets/images/default_no_image.jpeg';
  // static String defaultNoImageUser = 'assets/images/user.png';

  static String fontFamily1 = 'Formular'; 
  static String fontFamily2 = 'Cormorant'; 
  static String fontFamily3 = 'Mak'; 
  static String fontFamily4 = 'Gilroy'; 

}

enum App{
  siignores,
  secondApp
}

extension AppExtension on App{
  String get token {
    switch (this) {
      case App.siignores:
        return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWNrbmFtZSI6InNpaWdub3JlcyIsInRpbWVzdGFtcCI6IjE2NjE4MTIxNjEuNzQ3NDE3In0.ajIYCpHTRi7palf6wtIThR0XrxDSjXeP89ZF2BqkEtI';
      case App.secondApp:
        return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWNrbmFtZSI6InNpaWdub3JlcyIsInRpbWVzdGFtcCI6IjE2NjE4MTIxNjEuNzQ3NDE3In0.ajIYCpHTRi7palf6wtIThR0XrxDSjXeP89ZF2BqkEtI';
    }
  }

  bool get isSiignores {
    return this == App.siignores;
  }
}





