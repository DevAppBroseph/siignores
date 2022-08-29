


class MainConfigApp {

  //======== APP SETTINGS ========//

  static App app = App.secondApp; 


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
        return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWNrbmFtZSI6ImFwcDEiLCJ0aW1lc3RhbXAiOiIxNjYxNjIwNDc5LjY2MjEyOTYifQ.bo2WC5vOmB9wKptn-7BVjpMlWmvbIF6W4vQ2PPyM0MM';
      case App.secondApp:
        return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWNrbmFtZSI6ImFwcDEiLCJ0aW1lc3RhbXAiOiIxNjYxNjIwNDc5LjY2MjEyOTYifQ.bo2WC5vOmB9wKptn-7BVjpMlWmvbIF6W4vQ2PPyM0MM';
    }
  }

  bool get isSiignores {
    return this == App.siignores;
  }
}





