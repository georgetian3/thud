//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BodyLoginLoginPost {
  /// Returns a new [BodyLoginLoginPost] instance.
  BodyLoginLoginPost({
    this.grantType,
    required this.username,
    required this.password,
    this.scope = ,
    this.clientId,
    this.clientSecret,
  });

  Object? grantType;

  Object? username;

  Object? password;

  Object? scope;

  Object? clientId;

  Object? clientSecret;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BodyLoginLoginPost &&
     other.grantType == grantType &&
     other.username == username &&
     other.password == password &&
     other.scope == scope &&
     other.clientId == clientId &&
     other.clientSecret == clientSecret;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (grantType == null ? 0 : grantType!.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (scope == null ? 0 : scope!.hashCode) +
    (clientId == null ? 0 : clientId!.hashCode) +
    (clientSecret == null ? 0 : clientSecret!.hashCode);

  @override
  String toString() => 'BodyLoginLoginPost[grantType=$grantType, username=$username, password=$password, scope=$scope, clientId=$clientId, clientSecret=$clientSecret]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.grantType != null) {
      json[r'grant_type'] = this.grantType;
    } else {
      json[r'grant_type'] = null;
    }
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
    if (this.scope != null) {
      json[r'scope'] = this.scope;
    } else {
      json[r'scope'] = null;
    }
    if (this.clientId != null) {
      json[r'client_id'] = this.clientId;
    } else {
      json[r'client_id'] = null;
    }
    if (this.clientSecret != null) {
      json[r'client_secret'] = this.clientSecret;
    } else {
      json[r'client_secret'] = null;
    }
    return json;
  }

  /// Returns a new [BodyLoginLoginPost] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BodyLoginLoginPost? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BodyLoginLoginPost[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BodyLoginLoginPost[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BodyLoginLoginPost(
        grantType: mapValueOfType<Object>(json, r'grant_type'),
        username: mapValueOfType<Object>(json, r'username'),
        password: mapValueOfType<Object>(json, r'password'),
        scope: mapValueOfType<Object>(json, r'scope') ?? ,
        clientId: mapValueOfType<Object>(json, r'client_id'),
        clientSecret: mapValueOfType<Object>(json, r'client_secret'),
      );
    }
    return null;
  }

  static List<BodyLoginLoginPost> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BodyLoginLoginPost>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BodyLoginLoginPost.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BodyLoginLoginPost> mapFromJson(dynamic json) {
    final map = <String, BodyLoginLoginPost>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BodyLoginLoginPost.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BodyLoginLoginPost-objects as value to a dart map
  static Map<String, List<BodyLoginLoginPost>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BodyLoginLoginPost>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BodyLoginLoginPost.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'username',
    'password',
  };
}

