//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreatePostRequest {
  /// Returns a new [CreatePostRequest] instance.
  CreatePostRequest({
    this.tags = [],
    required this.title,
    required this.content,
    required this.location,
    this.mediaCount = 0,
  });

  Object? tags;

  Object? title;

  Object? content;

  Object? location;

  Object? mediaCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreatePostRequest &&
     other.tags == tags &&
     other.title == title &&
     other.content == content &&
     other.location == location &&
     other.mediaCount == mediaCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tags == null ? 0 : tags!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (content == null ? 0 : content!.hashCode) +
    (location == null ? 0 : location!.hashCode) +
    (mediaCount == null ? 0 : mediaCount!.hashCode);

  @override
  String toString() => 'CreatePostRequest[tags=$tags, title=$title, content=$content, location=$location, mediaCount=$mediaCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.tags != null) {
      json[r'tags'] = this.tags;
    } else {
      json[r'tags'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.content != null) {
      json[r'content'] = this.content;
    } else {
      json[r'content'] = null;
    }
    if (this.location != null) {
      json[r'location'] = this.location;
    } else {
      json[r'location'] = null;
    }
    if (this.mediaCount != null) {
      json[r'media_count'] = this.mediaCount;
    } else {
      json[r'media_count'] = null;
    }
    return json;
  }

  /// Returns a new [CreatePostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreatePostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreatePostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreatePostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreatePostRequest(
        tags: mapValueOfType<Object>(json, r'tags') ?? [],
        title: mapValueOfType<Object>(json, r'title'),
        content: mapValueOfType<Object>(json, r'content'),
        location: mapValueOfType<Object>(json, r'location'),
        mediaCount: mapValueOfType<Object>(json, r'media_count') ?? 0,
      );
    }
    return null;
  }

  static List<CreatePostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreatePostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreatePostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreatePostRequest> mapFromJson(dynamic json) {
    final map = <String, CreatePostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreatePostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreatePostRequest-objects as value to a dart map
  static Map<String, List<CreatePostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreatePostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreatePostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'content',
    'location',
  };
}

