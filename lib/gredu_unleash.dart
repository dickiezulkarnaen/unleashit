library unleashit;

import 'dart:convert';
import 'dart:developer';

import 'package:unleashit/gredu_unleash_config.dart';

import 'extention.dart';
import 'feature_flags_entity.dart';
import 'package:http/http.dart' as http;

class GreduUnleash {

  GreduUnleashConfig? config;

  Future init({required GreduUnleashConfig config}) async {
    this.config = config;
    await _getUnleashClient(this.config!);
    _checkInterval();
  }

  void _checkInterval() async {
    if (config != null) {
      if (config!.pollInterval != null) {
        await Future.delayed(config!.pollInterval!);
        _poll(config!.pollInterval!);
      }
    }
  }

  FeatureFlagsEntity? data;

  Future<void> _getUnleashClient(GreduUnleashConfig config) async {
    debug("GreduUnleash : fetching data...");
    final client = http.Client();
    await client.get(
        Uri.parse(config.proxyUrl),
        headers: config.headers
    ).then((value) => _onSuccess(jsonDecode(value.body)));
  }

  void _onSuccess(Map<String, dynamic> res) {
    data = FeatureFlagsEntity().fromJson(res);
    debug("UNLEASH RESPONSE ---> $res");
  }

  bool? _isEnabled(String toggleName) {
    bool? isEnabled = false;
    if (data?.toggles != null) {
      if (data!.toggles!.isNotEmpty) {
        data?.toggles?.forEach((element) {
          if (element.name == toggleName) {
            isEnabled = true;
          }
        });
      }
    }
    debug("toggleName = $toggleName, is enabled = $isEnabled");
    return isEnabled;
  }

  /// Check your feature is enabled or disabled
  /// Put your toggle name / feature name as params
  /// Toggle name should be representing which feature that you want to check
  /// It's nullable so you can put your own default value for each toggle
  bool? isFeatureEnabled(String toggleName) {
    if (config == null) {
      log("GreduUnleash hasn't initialized");
      return null;
    } else {
      return _isEnabled(toggleName);
    }
  }

  Future _poll(Duration interval) async {
    debug("GreduUnleash polling is started");
    var count = 0.0;
    bool flag = true;

    while (flag){
      count++;
      debug("going on $count");
      _getUnleashClient(config!);
      await Future.delayed(interval);
    }
  }

}

class _Config {

}