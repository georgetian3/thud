//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class User {
  /// Returns a new [User] instance.
  User({
    required this.id,
    required this.username,
    required this.profilePicture,
    required this.dateJoined,
    required this.email,
    required this.bio,
    this.posts = [],
    this.comments = [],
    this.liked = [],
    this.saved = [],
    this.followers = [],
    this.followees = [],
    this.blocking = [],
  });

  Object? id;

  Object? username;

  Object? profilePicture;

  Object? dateJoined;

  Object? email;

  Object? bio;

  Object? posts;

  Object? comments;

  Object? liked;

  Object? saved;

  Object? followers;

  Object? followees;

  Object? blocking;

  @override
  bool operator ==(Object other) => identical(this, other) || other is User &&
     other.id == id &&
     other.username == username &&
     other.profilePicture == profilePicture &&
     other.dateJoined == dateJoined &&
     other.email == email &&
     other.bio == bio &&
     other.posts == posts &&
     other.comments == comments &&
     other.liked == liked &&
     other.saved == saved &&
     other.followers == followers &&
     other.followees == followees &&
     other.blocking == blocking;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (profilePicture == null ? 0 : profilePicture!.hashCode) +
    (dateJoined == null ? 0 : dateJoined!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (bio == null ? 0 : bio!.hashCode) +
    (posts == null ? 0 : posts!.hashCode) +
    (comments == null ? 0 : comments!.hashCode) +
    (liked == null ? 0 : liked!.hashCode) +
    (saved == null ? 0 : saved!.hashCode) +
    (followers == null ? 0 : followers!.hashCode) +
    (followees == null ? 0 : followees!.hashCode) +
    (blocking == null ? 0 : blocking!.hashCode);

  @override
  String toString() => 'User[id=$id, username=$username, profilePicture=$profilePicture, dateJoined=$dateJoined, email=$email, bio=$bio, posts=$posts, comments=$comments, liked=$liked, saved=$saved, followers=$followers, followees=$followees, blocking=$blocking]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.profilePicture != null) {
      json[r'profile_picture'] = this.profilePicture;
    } else {
      json[r'profile_picture'] = null;
    }
    if (this.dateJoined != null) {
      json[r'date_joined'] = this.dateJoined;
    } else {
      json[r'date_joined'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.bio != null) {
      json[r'bio'] = this.bio;
    } else {
      json[r'bio'] = null;
    }
    if (this.posts != null) {
      json[r'posts'] = this.posts;
    } else {
      json[r'posts'] = null;
    }
    if (this.comments != null) {
      json[r'comments'] = this.comments;
    } else {
      json[r'comments'] = null;
    }
    if (this.liked != null) {
      json[r'liked'] = this.liked;
    } else {
      json[r'liked'] = null;
    }
    if (this.saved != null) {
      json[r'saved'] = this.saved;
    } else {
      json[r'saved'] = null;
    }
    if (this.followers != null) {
      json[r'followers'] = this.followers;
    } else {
      json[r'followers'] = null;
    }
    if (this.followees != null) {
      json[r'followees'] = this.followees;
    } else {
      json[r'followees'] = null;
    }
    if (this.blocking != null) {
      json[r'blocking'] = this.blocking;
    } else {
      json[r'blocking'] = null;
    }
    return json;
  }

  /// Returns a new [User] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static User? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "User[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "User[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return User(
        id: mapValueOfType<Object>(json, r'id'),
        username: mapValueOfType<Object>(json, r'username'),
        profilePicture: mapValueOfType<Object>(json, r'profile_picture'),
        dateJoined: mapValueOfType<Object>(json, r'date_joined'),
        email: mapValueOfType<Object>(json, r'email'),
        bio: mapValueOfType<Object>(json, r'bio'),
        posts: mapValueOfType<Object>(json, r'posts'),
        comments: mapValueOfType<Object>(json, r'comments'),
        liked: mapValueOfType<Object>(json, r'liked'),
        saved: mapValueOfType<Object>(json, r'saved'),
        followers: mapValueOfType<Object>(json, r'followers'),
        followees: mapValueOfType<Object>(json, r'followees'),
        blocking: mapValueOfType<Object>(json, r'blocking'),
      );
    }
    return null;
  }

  static List<User> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <User>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = User.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, User> mapFromJson(dynamic json) {
    final map = <String, User>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = User.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of User-objects as value to a dart map
  static Map<String, List<User>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<User>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = User.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'username',
    'profile_picture',
    'date_joined',
    'email',
    'bio',
    'posts',
    'comments',
    'liked',
    'saved',
    'followers',
    'followees',
    'blocking',
  };
}

