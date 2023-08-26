//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Chat {
  /// Returns a new [Chat] instance.
  Chat({
    required this.messages,
  });

  Object? messages;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Chat &&
     other.messages == messages;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messages == null ? 0 : messages!.hashCode);

  @override
  String toString() => 'Chat[messages=$messages]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.messages != null) {
      json[r'messages'] = this.messages;
    } else {
      json[r'messages'] = null;
    }
    return json;
  }

  /// Returns a new [Chat] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Chat? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Chat[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Chat[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Chat(
        messages: mapValueOfType<Object>(json, r'messages'),
      );
    }
    return null;
  }

  static List<Chat> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Chat>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Chat.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Chat> mapFromJson(dynamic json) {
    final map = <String, Chat>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Chat.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Chat-objects as value to a dart map
  static Map<String, List<Chat>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Chat>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Chat.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'messages',
  };
}

