//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChangePasswordRequest {
  /// Returns a new [ChangePasswordRequest] instance.
  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Object? oldPassword;

  Object? newPassword;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChangePasswordRequest &&
     other.oldPassword == oldPassword &&
     other.newPassword == newPassword;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (oldPassword == null ? 0 : oldPassword!.hashCode) +
    (newPassword == null ? 0 : newPassword!.hashCode);

  @override
  String toString() => 'ChangePasswordRequest[oldPassword=$oldPassword, newPassword=$newPassword]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.oldPassword != null) {
      json[r'old_password'] = this.oldPassword;
    } else {
      json[r'old_password'] = null;
    }
    if (this.newPassword != null) {
      json[r'new_password'] = this.newPassword;
    } else {
      json[r'new_password'] = null;
    }
    return json;
  }

  /// Returns a new [ChangePasswordRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChangePasswordRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChangePasswordRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChangePasswordRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChangePasswordRequest(
        oldPassword: mapValueOfType<Object>(json, r'old_password'),
        newPassword: mapValueOfType<Object>(json, r'new_password'),
      );
    }
    return null;
  }

  static List<ChangePasswordRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChangePasswordRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChangePasswordRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChangePasswordRequest> mapFromJson(dynamic json) {
    final map = <String, ChangePasswordRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChangePasswordRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChangePasswordRequest-objects as value to a dart map
  static Map<String, List<ChangePasswordRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChangePasswordRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChangePasswordRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'old_password',
    'new_password',
  };
}

