//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ContentApi {
  ContentApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Comment
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  ///
  /// * [CreateCommentRequest] createCommentRequest (required):
  Future<Response> createCommentPostsPostIdCommentsPutWithHttpInfo(Object postId, CreateCommentRequest createCommentRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/{post_id}/comments'
      .replaceAll('{post_id}', postId.toString());

    // ignore: prefer_final_locals
    Object? postBody = createCommentRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create Comment
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  ///
  /// * [CreateCommentRequest] createCommentRequest (required):
  Future<Comment?> createCommentPostsPostIdCommentsPut(Object postId, CreateCommentRequest createCommentRequest,) async {
    final response = await createCommentPostsPostIdCommentsPutWithHttpInfo(postId, createCommentRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Comment',) as Comment;
    
    }
    return null;
  }

  /// Create Post
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreatePostRequest] createPostRequest (required):
  Future<Response> createPostPostsPutWithHttpInfo(CreatePostRequest createPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts';

    // ignore: prefer_final_locals
    Object? postBody = createPostRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create Post
  ///
  /// Parameters:
  ///
  /// * [CreatePostRequest] createPostRequest (required):
  Future<CreatePostSuccessResponse?> createPostPostsPut(CreatePostRequest createPostRequest,) async {
    final response = await createPostPostsPutWithHttpInfo(createPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreatePostSuccessResponse',) as CreatePostSuccessResponse;
    
    }
    return null;
  }

  /// Get Media
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] mediaId (required):
  Future<Response> getMediaMediaMediaIdGetWithHttpInfo(Object mediaId,) async {
    // ignore: prefer_const_declarations
    final path = r'/media/{media_id}'
      .replaceAll('{media_id}', mediaId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Media
  ///
  /// Parameters:
  ///
  /// * [Object] mediaId (required):
  Future<Object?> getMediaMediaMediaIdGet(Object mediaId,) async {
    final response = await getMediaMediaMediaIdGetWithHttpInfo(mediaId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }

  /// Get Post
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<Response> getPostPostsPostIdGetWithHttpInfo(Object postId,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/{post_id}'
      .replaceAll('{post_id}', postId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Post
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<Post?> getPostPostsPostIdGet(Object postId,) async {
    final response = await getPostPostsPostIdGetWithHttpInfo(postId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Post',) as Post;
    
    }
    return null;
  }

  /// Like
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<Response> likePostsPostIdLikePatchWithHttpInfo(Object postId,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/{post_id}/like'
      .replaceAll('{post_id}', postId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Like
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<void> likePostsPostIdLikePatch(Object postId,) async {
    final response = await likePostsPostIdLikePatchWithHttpInfo(postId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Put Media
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] mediaId (required):
  ///
  /// * [Object] file (required):
  Future<Response> putMediaMediaMediaIdPutWithHttpInfo(Object mediaId, Object file,) async {
    // ignore: prefer_const_declarations
    final path = r'/media/{media_id}'
      .replaceAll('{media_id}', mediaId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('PUT', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = parameterToString(file);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Put Media
  ///
  /// Parameters:
  ///
  /// * [Object] mediaId (required):
  ///
  /// * [Object] file (required):
  Future<Object?> putMediaMediaMediaIdPut(Object mediaId, Object file,) async {
    final response = await putMediaMediaMediaIdPutWithHttpInfo(mediaId, file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }

  /// Save
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<Response> savePostsPostIdSavePatchWithHttpInfo(Object postId,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/{post_id}/save'
      .replaceAll('{post_id}', postId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Save
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<void> savePostsPostIdSavePatch(Object postId,) async {
    final response = await savePostsPostIdSavePatchWithHttpInfo(postId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Search Posts
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SearchContentRequest] searchContentRequest (required):
  Future<Response> searchPostsPostsPostWithHttpInfo(SearchContentRequest searchContentRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/';

    // ignore: prefer_final_locals
    Object? postBody = searchContentRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Search Posts
  ///
  /// Parameters:
  ///
  /// * [SearchContentRequest] searchContentRequest (required):
  Future<Object?> searchPostsPostsPost(SearchContentRequest searchContentRequest,) async {
    final response = await searchPostsPostsPostWithHttpInfo(searchContentRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }

  /// Unlike
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<Response> unlikePostsPostIdUnlikePatchWithHttpInfo(Object postId,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/{post_id}/unlike'
      .replaceAll('{post_id}', postId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Unlike
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<void> unlikePostsPostIdUnlikePatch(Object postId,) async {
    final response = await unlikePostsPostIdUnlikePatchWithHttpInfo(postId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Unsave
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<Response> unsavePostsPostIdUnsavePatchWithHttpInfo(Object postId,) async {
    // ignore: prefer_const_declarations
    final path = r'/posts/{post_id}/unsave'
      .replaceAll('{post_id}', postId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Unsave
  ///
  /// Parameters:
  ///
  /// * [Object] postId (required):
  Future<void> unsavePostsPostIdUnsavePatch(Object postId,) async {
    final response = await unsavePostsPostIdUnsavePatchWithHttpInfo(postId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
