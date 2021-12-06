# GREDU-UNLEASH

Tools for toggling features that we can enable or disable a feature.


Add to your pubspec.yaml

```yaml
dependencies:
  gredu-unleash: x.y.z
```

Initialize on your main.dart, we recommended use it as singleton

```dart
final config = GreduUnleashConfig(
          proxyUrl: <Proxy URL>,
          headers: <Headers>
      );

final unleash = GreduUnleash.init(config);
```

*Notes : Polling Interval is optional, but we don't use it for now

Check is a feature enabled :

```dart
if (unleash.isFeatureEnabled("payment")) {
			// Enable feature
		} else {
			// Disable feature
		}
}
```

More Information : [https://docs.getunleash.io/](https://docs.getunleash.io/)