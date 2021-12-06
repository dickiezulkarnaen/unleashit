import 'package:unleashit/generated/json/base/json_convert_content.dart';


/// This Response Model Class is an open source standard

class FeatureFlagsEntity with JsonConvert<FeatureFlagsEntity> {
	List<FeatureFlagsToggles>? toggles;
}

class FeatureFlagsToggles with JsonConvert<FeatureFlagsToggles> {
	String? name;
	bool? enabled;
	FeatureFlagsTogglesVariant? variant;
}

class FeatureFlagsTogglesVariant with JsonConvert<FeatureFlagsTogglesVariant> {
	String? name;
	bool? enabled;
}
