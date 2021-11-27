import 'package:unleashit/feature_flags_entity.dart';

featureFlagsEntityFromJson(FeatureFlagsEntity data, Map<String, dynamic> json) {
	if (json['toggles'] != null) {
		data.toggles = (json['toggles'] as List).map((v) => FeatureFlagsToggles().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> featureFlagsEntityToJson(FeatureFlagsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['toggles'] =  entity.toggles?.map((v) => v.toJson())?.toList();
	return data;
}

featureFlagsTogglesFromJson(FeatureFlagsToggles data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['enabled'] != null) {
		data.enabled = json['enabled'];
	}
	if (json['variant'] != null) {
		data.variant = FeatureFlagsTogglesVariant().fromJson(json['variant']);
	}
	return data;
}

Map<String, dynamic> featureFlagsTogglesToJson(FeatureFlagsToggles entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['enabled'] = entity.enabled;
	data['variant'] = entity.variant?.toJson();
	return data;
}

featureFlagsTogglesVariantFromJson(FeatureFlagsTogglesVariant data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['enabled'] != null) {
		data.enabled = json['enabled'];
	}
	return data;
}

Map<String, dynamic> featureFlagsTogglesVariantToJson(FeatureFlagsTogglesVariant entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['enabled'] = entity.enabled;
	return data;
}