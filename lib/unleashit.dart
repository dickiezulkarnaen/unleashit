library unleashit;

import 'dart:convert';
import 'dart:developer';

import 'feature_flags_entity.dart';
import 'package:http/http.dart' as http;

class FeatureFlagManager {

  final String proxyUrl;
  final String clientSecret;
  final String env;
  final String persona;
  int interval = 60;

  //DIBIKIN PARAMETER KARENA ADA KEMUNGKINAN DIBIKIN LIBRARY BENERAN.
  //TAPI BARU KEMUNGKINAN LHO YA...
  FeatureFlagManager({
    required this.proxyUrl,
    required this.clientSecret,
    required this.env,
    required this.persona,
    this.interval = 60
  }) {
    start();
    log("FeatureFlagManager is started");
  }

  FeatureFlagsEntity? _flags;

  Future<void> _getUnleashClient() async {
    final client = http.Client();
    client.get(
        Uri.parse(proxyUrl),
        headers: { "Authorization" : clientSecret }
    ).then((value) => onSuccess(jsonDecode(value.body)));
  }

  void onSuccess(Map<String, dynamic> res) {
    _flags = FeatureFlagsEntity().fromJson(res);
    log("UNLEASH RESPONSE ==> $res");
  }

  String _getToggleName(String featureName) {
    return "mobile.$env.$persona.$featureName";
  }

  bool _isEnabled(String toggleName) {
    var isEnabled = false;
    if (_flags?.toggles != null) {
      if (_flags!.toggles!.isNotEmpty) {
        _flags?.toggles?.forEach((element) {
          if (element.name == toggleName) {
            isEnabled = true;
          }
        });
      }
    }
    log("ToggleName = $toggleName, is enabled = $isEnabled");
    return isEnabled;
  }

  // for example before real implementation
  bool isFeatureEnabled(String featureName) {
    return _isEnabled(_getToggleName(featureName));
  }

  Future start() async {
    var count = 0.0;
    bool flag = true;

    while (flag){
      count++;
      log("going on: $count");
      await _getUnleashClient();
      await Future.delayed(Duration(seconds: interval));
    }
  }

}