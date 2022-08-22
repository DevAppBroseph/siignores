
enum Config { baseUrl, baseScheme, baseAPIpath, url }

const bool isDev = true;

String myUrl = '176.113.83.169';

extension ConfigExtension on Config {
  String get value {
    switch (this) {
      case Config.baseUrl:
        return !isDev ? "REALURL" : myUrl;
      case Config.baseAPIpath:
        return '';
      case Config.url:
        return url;
      default:
        return 'http';
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

  String get urlWithoutApi {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value;
  }
}
