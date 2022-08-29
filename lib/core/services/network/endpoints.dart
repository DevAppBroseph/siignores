import 'config.dart';
import 'dart:core';

enum Endpoints {
  // Authentication
  register,
  activationCode,
  setPassword,
    //Login and user
  login,
  logout,
  getUserInfo,
  

  //Forgot password
  sendCodeForResetPassword,
  verifyCodeForResetPassword,
  resetPassword,


  //Profile
  updateProfileInfo,
  updateAvatar,


  //Training
  getCourses,
  getModules,


  //Chat
  getChatTabs,
  getChatMessages
}

extension EndpointsExtension on Endpoints {
  String getPath({
    List<dynamic>? params,
  }) {
    var url = Config.url.url;
    switch (this) {
      case Endpoints.register:
        return "$url/auth/users/";
      case Endpoints.activationCode:
        return "$url/auth/users/activation/";
      case Endpoints.getUserInfo:
        return "$url/auth/users/me/";
      case Endpoints.setPassword:
        return "$url/auth/users/set_password/";
      case Endpoints.login:
        return "$url/auth/token/login/";
      case Endpoints.logout:
        return "$url/auth/token/logout/";
      case Endpoints.resetPassword:
        return "$url/auth/users/reset_password_confirm/";
      case Endpoints.sendCodeForResetPassword:
        return "$url/auth/users/reset_password/";
      case Endpoints.verifyCodeForResetPassword:
        return "$url/auth/users/check_code/";
      case Endpoints.updateProfileInfo:
        return "$url/auth/users/me/";
      case Endpoints.updateAvatar:
        return "$url/auth/users/change_photo/";
      case Endpoints.getCourses:
        return "$url/courses/course/get_courses/";
      case Endpoints.getModules:
        return "$url/courses/course/get_modules${params![0]}/";
      case Endpoints.getChatTabs:
        return "$url/chat/all/";
      case Endpoints.getChatMessages:
        return "$url/chat/${params![0]}/";
      default:
        return '';
    }
  }

  String get hostName {
    return Config.baseUrl.value;
  }

  String get scheme {
    return Config.baseScheme.value;
  }

  String get path {
    return Config.baseAPIpath.value;
  }

  Map<String, String> getHeaders(
      {String token = '', required Map<String, String> defaultHeaders}) {
    return {
      if (defaultHeaders != null) ...defaultHeaders,
      if (defaultHeaders == null) ...{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      if (token != '') ...{'Authorization': 'Token $token'}
    };
  }

  Uri buildURL(
      {Map<String, dynamic>? queryParameters, List<dynamic>? urlParams}) {
    var url = Uri(
        scheme: this.scheme,
        host: this.hostName,
        path: this.getPath(params: urlParams),
        queryParameters: queryParameters ?? {});
    return url;
  }
}

