//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendMessageRequest {
  /// Returns a new [SendMessageRequest] instance.
  SendMessageRequest({
    required this.receiver,
    required this.message,
  });

  Object? receiver;

  Object? message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendMessageRequest &&
     other.receiver == receiver &&
     other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (receiver == null ? 0 : receiver!.hashCode) +
    (message == null ? 0 : message!.hashCode);

  @override
  String toString() => 'SendMessageRequest[receiver=$receiver, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.receiver != null) {
      json[r'receiver'] = this.receiver;
    } else {
      json[r'receiver'] = null;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    } else {
      json[r'message'] = null;
    }
    return json;
  }

  /// Returns a new [SendMessageRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendMessageRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SendMessageRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SendMessageRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SendMessageRequest(
        receiver: mapValueOfType<Object>(json, r'receiver'),
        message: mapValueOfType<Object>(json, r'message'),
      );
    }
    return null;
  }

  static List<SendMessageRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendMessageRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendMessageRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendMessageRequest> mapFromJson(dynamic json) {
    final map = <String, SendMessageRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendMessageRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendMessageRequest-objects as value to a dart map
  static Map<String, List<SendMessageRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendMessageRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendMessageRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'receiver',
    'message',
  };
}

