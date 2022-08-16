import 'config.dart';
import 'dart:core';

enum Endpoints {
  // Authentication
  sendCode,
  

}

extension EndpointsExtension on Endpoints {
  String getPath({
    List<dynamic>? params,
  }) {
    var url = Config.url.url;
    var reviewsUrl = Config.url.urlReviews;
    switch (this) {
      case Endpoints.sendCode:
        return "$url/send-code/";
     
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

