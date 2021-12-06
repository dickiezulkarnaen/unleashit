
/// This is a configuration for start using GreduUnleash
/// It's contains Credential that provided by Unleash administrator
class GreduUnleashConfig {

  /// Use provided proxy URL by your Unleash administrator.
  /// Once again, we just use opensource standard API Access.
  /// One API Endpoint, one response
  /// Example : http://host-name/api/proxy
  final String proxyUrl;

  /// You can use multiple Authentication.
  /// We provide single API Endpoint but you can put additional Authentication for your own server
  /// Typically, credential/client key/client secret attributes
  final Map<String, String> headers;

  /// If you want to enable poll mode, put poll interval / duration
  /// Keep in mind that use polling mode gonna take much memory & resource
  /// But if you want to fetch data in single time, keep it null. And it will called on 'init' method
  Duration? pollInterval;

  GreduUnleashConfig({
    required this.proxyUrl,
    required this.headers,
    this.pollInterval
  });

}