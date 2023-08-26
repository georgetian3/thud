//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChangeUsernameRequest {
  /// Returns a new [ChangeUsernameRequest] instance.
  ChangeUsernameRequest({
    required this.newUsername,
  });

  Object? newUsername;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChangeUsernameRequest &&
     other.newUsername == newUsername;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (newUsername == null ? 0 : newUsername!.hashCode);

  @override
  String toString() => 'ChangeUsernameRequest[newUsername=$newUsername]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.newUsername != null) {
      json[r'new_username'] = this.newUsername;
    } else {
      json[r'new_username'] = null;
    }
    return json;
  }

  /// Returns a new [ChangeUsernameRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChangeUsernameRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChangeUsernameRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChangeUsernameRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChangeUsernameRequest(
        newUsername: mapValueOfType<Object>(json, r'new_username'),
      );
    }
    return null;
  }

  static List<ChangeUsernameRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChangeUsernameRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChangeUsernameRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChangeUsernameRequest> mapFromJson(dynamic json) {
    final map = <String, ChangeUsernameRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChangeUsernameRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChangeUsernameRequest-objects as value to a dart map
  static Map<String, List<ChangeUsernameRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChangeUsernameRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChangeUsernameRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'new_username',
  };
}

