//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Post {
  /// Returns a new [Post] instance.
  Post({
    required this.id,
    required this.creator,
    required this.title,
    required this.content,
    required this.location,
    required this.dateCreated,
    required this.tags,
    required this.media,
    required this.comments,
    required this.likers,
    required this.savers,
  });

  Object? id;

  Object? creator;

  Object? title;

  Object? content;

  Object? location;

  Object? dateCreated;

  Object? tags;

  Object? media;

  Object? comments;

  Object? likers;

  Object? savers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Post &&
     other.id == id &&
     other.creator == creator &&
     other.title == title &&
     other.content == content &&
     other.location == location &&
     other.dateCreated == dateCreated &&
     other.tags == tags &&
     other.media == media &&
     other.comments == comments &&
     other.likers == likers &&
     other.savers == savers;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (creator == null ? 0 : creator!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (content == null ? 0 : content!.hashCode) +
    (location == null ? 0 : location!.hashCode) +
    (dateCreated == null ? 0 : dateCreated!.hashCode) +
    (tags == null ? 0 : tags!.hashCode) +
    (media == null ? 0 : media!.hashCode) +
    (comments == null ? 0 : comments!.hashCode) +
    (likers == null ? 0 : likers!.hashCode) +
    (savers == null ? 0 : savers!.hashCode);

  @override
  String toString() => 'Post[id=$id, creator=$creator, title=$title, content=$content, location=$location, dateCreated=$dateCreated, tags=$tags, media=$media, comments=$comments, likers=$likers, savers=$savers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.creator != null) {
      json[r'creator'] = this.creator;
    } else {
      json[r'creator'] = null;
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
    if (this.dateCreated != null) {
      json[r'date_created'] = this.dateCreated;
    } else {
      json[r'date_created'] = null;
    }
    if (this.tags != null) {
      json[r'tags'] = this.tags;
    } else {
      json[r'tags'] = null;
    }
    if (this.media != null) {
      json[r'media'] = this.media;
    } else {
      json[r'media'] = null;
    }
    if (this.comments != null) {
      json[r'comments'] = this.comments;
    } else {
      json[r'comments'] = null;
    }
    if (this.likers != null) {
      json[r'likers'] = this.likers;
    } else {
      json[r'likers'] = null;
    }
    if (this.savers != null) {
      json[r'savers'] = this.savers;
    } else {
      json[r'savers'] = null;
    }
    return json;
  }

  /// Returns a new [Post] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Post? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Post[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Post[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Post(
        id: mapValueOfType<Object>(json, r'id'),
        creator: mapValueOfType<Object>(json, r'creator'),
        title: mapValueOfType<Object>(json, r'title'),
        content: mapValueOfType<Object>(json, r'content'),
        location: mapValueOfType<Object>(json, r'location'),
        dateCreated: mapValueOfType<Object>(json, r'date_created'),
        tags: mapValueOfType<Object>(json, r'tags'),
        media: mapValueOfType<Object>(json, r'media'),
        comments: mapValueOfType<Object>(json, r'comments'),
        likers: mapValueOfType<Object>(json, r'likers'),
        savers: mapValueOfType<Object>(json, r'savers'),
      );
    }
    return null;
  }

  static List<Post> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Post>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Post.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Post> mapFromJson(dynamic json) {
    final map = <String, Post>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Post.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Post-objects as value to a dart map
  static Map<String, List<Post>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Post>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Post.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'creator',
    'title',
    'content',
    'location',
    'date_created',
    'tags',
    'media',
    'comments',
    'likers',
    'savers',
  };
}

