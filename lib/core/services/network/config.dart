
enum Config { baseUrl, baseScheme, baseAPIpath, reviewsAPIpath, url }

const bool isDev = true;

// const String myUrl = '0.0.0.0';
String myUrl = 'URL_TO_API';

extension ConfigExtension on Config {
  String get value {
    switch (this) {
      case Config.baseUrl:
        return !isDev ? "REALURL" : myUrl;
      case Config.baseAPIpath:
        return 'api/v1';
      case Config.reviewsAPIpath:
        return 'reviews-api/v1';
      case Config.url:
        return url;
      default:
        return 'https';
    }
  }

  String get url {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value +
        '/' +
        Config.baseAPIpath.value;
  }

  String get urlReviews {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value +
        '/' +
        Config.reviewsAPIpath.value;
  }

  String get urlWithoutApi {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value;
  }
}
