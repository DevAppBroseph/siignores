
enum Config { baseUrl, baseScheme, baseAPIpath, url, ws }

const bool isDev = true;

String myUrl = '176.113.83.169';

extension ConfigExtension on Config {
  String get value {
    switch (this) {
      case Config.baseUrl:
        return !isDev ? "REALURL" : myUrl;
      case Config.baseAPIpath:
        return '';
      case Config.ws:
        return 'ws';
      case Config.url:
        return url;
      default:
        return 'https';
    }
  }

  String get url {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value;
        // +
        // '/' +
        // Config.baseAPIpath.value;
  }
  String get ws {
    return Config.ws.value +
        "://" +
        Config.baseUrl.value +
        ":8000";
  }

  String get urlWithoutApi {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value;
  }
}
