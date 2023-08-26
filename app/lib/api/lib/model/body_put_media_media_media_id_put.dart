//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BodyPutMediaMediaMediaIdPut {
  /// Returns a new [BodyPutMediaMediaMediaIdPut] instance.
  BodyPutMediaMediaMediaIdPut({
    required this.file,
  });

  Object? file;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BodyPutMediaMediaMediaIdPut &&
     other.file == file;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (file == null ? 0 : file!.hashCode);

  @override
  String toString() => 'BodyPutMediaMediaMediaIdPut[file=$file]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.file != null) {
      json[r'file'] = this.file;
    } else {
      json[r'file'] = null;
    }
    return json;
  }

  /// Returns a new [BodyPutMediaMediaMediaIdPut] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BodyPutMediaMediaMediaIdPut? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BodyPutMediaMediaMediaIdPut[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BodyPutMediaMediaMediaIdPut[$key]" has a null value in JSON.');
return null;

//        });
//        return true;
//      }());

      return BodyPutMediaMediaMediaIdPut(
        file: mapValueOfType<Object>(json, r'file'),
      );
    }
    return null;
  }

  static List<BodyPutMediaMediaMediaIdPut> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BodyPutMediaMediaMediaIdPut>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BodyPutMediaMediaMediaIdPut.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BodyPutMediaMediaMediaIdPut> mapFromJson(dynamic json) {
    final map = <String, BodyPutMediaMediaMediaIdPut>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BodyPutMediaMediaMediaIdPut.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BodyPutMediaMediaMediaIdPut-objects as value to a dart map
  static Map<String, List<BodyPutMediaMediaMediaIdPut>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BodyPutMediaMediaMediaIdPut>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BodyPutMediaMediaMediaIdPut.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'file',
  };
}

