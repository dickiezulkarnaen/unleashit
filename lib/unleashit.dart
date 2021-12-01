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
  Duration? pollInterval;

  FeatureFlagManager({
    required this.proxyUrl,
    required this.clientSecret,
    required this.env,
    required this.persona,
    this.pollInterval
  });

  Future fetch() async {
    log("FeatureFlagManager is initialized");
    await _getUnleashClient();
    checkInterval();
  }

  void checkInterval() async {
    if (pollInterval != null) {
      await Future.delayed(pollInterval!);
      _poll(pollInterval!);
    }
  }

  FeatureFlagsEntity? _flags;

  Future<void> _getUnleashClient() async {
    final client = http.Client();
    await client.get(
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

  bool isFeatureEnabled(String featureName) {
    return _isEnabled(_getToggleName(featureName));
  }

  Future _poll(Duration interval) async {
    log("FeatureFlagManager polling is started");
    var count = 0.0;
    bool flag = true;

    while (flag){
      count++;
      log("going on: $count");
      _getUnleashClient();
      await Future.delayed(interval);
    }
  }

}