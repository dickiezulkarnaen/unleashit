
class GreduUnleashConfig {
  /// Use provided proxy URL by your Unleash administrator.
  /// Once again, we just use opensource standard API Access.
  /// One API Endpoint, one response
  /// Example : http://host-name/api/proxy
  final String proxyUrl;

  /// You can use multiple Authentication.
  /// We provide single API Endpoint but you can put additional Authentication for your own server
  final Map<String, String> headers;


  /// If you want to enable poll mode, put poll interval / duration
  /// But if you want to fetch data in single time, keep it null
  Duration? pollInterval;

  GreduUnleashConfig({
    required this.proxyUrl,
    required this.headers,
    this.pollInterval
  });

}