//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SearchContentRequest {
  /// Returns a new [SearchContentRequest] instance.
  SearchContentRequest({
    this.keywords = ,
    this.followedOnly = false,
    this.searchTitle = true,
    this.searchTags = true,
    this.searchContent = true,
    this.searchUsername = true,
    this.searchComments = true,
    this.sortMethod = new,
  });

  Object? keywords;

  Object? followedOnly;

  Object? searchTitle;

  Object? searchTags;

  Object? searchContent;

  Object? searchUsername;

  Object? searchComments;

  Object? sortMethod;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SearchContentRequest &&
     other.keywords == keywords &&
     other.followedOnly == followedOnly &&
     other.searchTitle == searchTitle &&
     other.searchTags == searchTags &&
     other.searchContent == searchContent &&
     other.searchUsername == searchUsername &&
     other.searchComments == searchComments &&
     other.sortMethod == sortMethod;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (keywords == null ? 0 : keywords!.hashCode) +
    (followedOnly == null ? 0 : followedOnly!.hashCode) +
    (searchTitle == null ? 0 : searchTitle!.hashCode) +
    (searchTags == null ? 0 : searchTags!.hashCode) +
    (searchContent == null ? 0 : searchContent!.hashCode) +
    (searchUsername == null ? 0 : searchUsername!.hashCode) +
    (searchComments == null ? 0 : searchComments!.hashCode) +
    (sortMethod == null ? 0 : sortMethod!.hashCode);

  @override
  String toString() => 'SearchContentRequest[keywords=$keywords, followedOnly=$followedOnly, searchTitle=$searchTitle, searchTags=$searchTags, searchContent=$searchContent, searchUsername=$searchUsername, searchComments=$searchComments, sortMethod=$sortMethod]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.keywords != null) {
      json[r'keywords'] = this.keywords;
    } else {
      json[r'keywords'] = null;
    }
    if (this.followedOnly != null) {
      json[r'followed_only'] = this.followedOnly;
    } else {
      json[r'followed_only'] = null;
    }
    if (this.searchTitle != null) {
      json[r'search_title'] = this.searchTitle;
    } else {
      json[r'search_title'] = null;
    }
    if (this.searchTags != null) {
      json[r'search_tags'] = this.searchTags;
    } else {
      json[r'search_tags'] = null;
    }
    if (this.searchContent != null) {
      json[r'search_content'] = this.searchContent;
    } else {
      json[r'search_content'] = null;
    }
    if (this.searchUsername != null) {
      json[r'search_username'] = this.searchUsername;
    } else {
      json[r'search_username'] = null;
    }
    if (this.searchComments != null) {
      json[r'search_comments'] = this.searchComments;
    } else {
      json[r'search_comments'] = null;
    }
    if (this.sortMethod != null) {
      json[r'sort_method'] = this.sortMethod;
    } else {
      json[r'sort_method'] = null;
    }
    return json;
  }

  /// Returns a new [SearchContentRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SearchContentRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SearchContentRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SearchContentRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SearchContentRequest(
        keywords: mapValueOfType<Object>(json, r'keywords') ?? ,
        followedOnly: mapValueOfType<Object>(json, r'followed_only') ?? false,
        searchTitle: mapValueOfType<Object>(json, r'search_title') ?? true,
        searchTags: mapValueOfType<Object>(json, r'search_tags') ?? true,
        searchContent: mapValueOfType<Object>(json, r'search_content') ?? true,
        searchUsername: mapValueOfType<Object>(json, r'search_username') ?? true,
        searchComments: mapValueOfType<Object>(json, r'search_comments') ?? true,
        sortMethod: mapValueOfType<Object>(json, r'sort_method') ?? new,
      );
    }
    return null;
  }

  static List<SearchContentRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SearchContentRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SearchContentRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SearchContentRequest> mapFromJson(dynamic json) {
    final map = <String, SearchContentRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SearchContentRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SearchContentRequest-objects as value to a dart map
  static Map<String, List<SearchContentRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SearchContentRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SearchContentRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

