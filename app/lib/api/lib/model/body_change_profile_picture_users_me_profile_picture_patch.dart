//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BodyChangeProfilePictureUsersMeProfilePicturePatch {
  /// Returns a new [BodyChangeProfilePictureUsersMeProfilePicturePatch] instance.
  BodyChangeProfilePictureUsersMeProfilePicturePatch({
    required this.profilePicture,
  });

  Object? profilePicture;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BodyChangeProfilePictureUsersMeProfilePicturePatch &&
     other.profilePicture == profilePicture;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profilePicture == null ? 0 : profilePicture!.hashCode);

  @override
  String toString() => 'BodyChangeProfilePictureUsersMeProfilePicturePatch[profilePicture=$profilePicture]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.profilePicture != null) {
      json[r'profile_picture'] = this.profilePicture;
    } else {
      json[r'profile_picture'] = null;
    }
    return json;
  }

  /// Returns a new [BodyChangeProfilePictureUsersMeProfilePicturePatch] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BodyChangeProfilePictureUsersMeProfilePicturePatch? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BodyChangeProfilePictureUsersMeProfilePicturePatch[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BodyChangeProfilePictureUsersMeProfilePicturePatch[$key]" has a null value in JSON.');
return null;

//        });
//        return true;
//      }());

      return BodyChangeProfilePictureUsersMeProfilePicturePatch(
        profilePicture: mapValueOfType<Object>(json, r'profile_picture'),
      );
    }
    return null;
  }

  static List<BodyChangeProfilePictureUsersMeProfilePicturePatch> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BodyChangeProfilePictureUsersMeProfilePicturePatch>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BodyChangeProfilePictureUsersMeProfilePicturePatch.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BodyChangeProfilePictureUsersMeProfilePicturePatch> mapFromJson(dynamic json) {
    final map = <String, BodyChangeProfilePictureUsersMeProfilePicturePatch>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BodyChangeProfilePictureUsersMeProfilePicturePatch.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BodyChangeProfilePictureUsersMeProfilePicturePatch-objects as value to a dart map
  static Map<String, List<BodyChangeProfilePictureUsersMeProfilePicturePatch>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BodyChangeProfilePictureUsersMeProfilePicturePatch>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BodyChangeProfilePictureUsersMeProfilePicturePatch.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_picture',
  };
}

