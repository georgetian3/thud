//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UsersApi {
  UsersApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Block
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<Response> blockUsersIdUserIdBlockPostWithHttpInfo(Object userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/id/{user_id}/block'
      .replaceAll('{user_id}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Block
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<void> blockUsersIdUserIdBlockPost(Object userId,) async {
    final response = await blockUsersIdUserIdBlockPostWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Change Bio
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ChangeBioRequest] changeBioRequest (required):
  Future<Response> changeBioUsersMeBioPatchWithHttpInfo(ChangeBioRequest changeBioRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/me/bio';

    // ignore: prefer_final_locals
    Object? postBody = changeBioRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Change Bio
  ///
  /// Parameters:
  ///
  /// * [ChangeBioRequest] changeBioRequest (required):
  Future<void> changeBioUsersMeBioPatch(ChangeBioRequest changeBioRequest,) async {
    final response = await changeBioUsersMeBioPatchWithHttpInfo(changeBioRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Change Password
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ChangePasswordRequest] changePasswordRequest (required):
  Future<Response> changePasswordUsersMePasswordPatchWithHttpInfo(ChangePasswordRequest changePasswordRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/me/password';

    // ignore: prefer_final_locals
    Object? postBody = changePasswordRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Change Password
  ///
  /// Parameters:
  ///
  /// * [ChangePasswordRequest] changePasswordRequest (required):
  Future<Token?> changePasswordUsersMePasswordPatch(ChangePasswordRequest changePasswordRequest,) async {
    final response = await changePasswordUsersMePasswordPatchWithHttpInfo(changePasswordRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Token',) as Token;
    
    }
    return null;
  }

  /// Change Profile Picture
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] profilePicture (required):
  Future<Response> changeProfilePictureUsersMeProfilePicturePatchWithHttpInfo(Object profilePicture,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/me/profile-picture';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('PATCH', Uri.parse(path));
    if (profilePicture != null) {
      hasFields = true;
      mp.fields[r'profile_picture'] = parameterToString(profilePicture);
    }
    if (hasFields) {
      postBody = mp;
    }

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

  /// Change Profile Picture
  ///
  /// Parameters:
  ///
  /// * [Object] profilePicture (required):
  Future<ProfilePictureId?> changeProfilePictureUsersMeProfilePicturePatch(Object profilePicture,) async {
    final response = await changeProfilePictureUsersMeProfilePicturePatchWithHttpInfo(profilePicture,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfilePictureId',) as ProfilePictureId;
    
    }
    return null;
  }

  /// Change Username
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ChangeUsernameRequest] changeUsernameRequest (required):
  Future<Response> changeUsernameUsersMeUsernamePatchWithHttpInfo(ChangeUsernameRequest changeUsernameRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/me/username';

    // ignore: prefer_final_locals
    Object? postBody = changeUsernameRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Change Username
  ///
  /// Parameters:
  ///
  /// * [ChangeUsernameRequest] changeUsernameRequest (required):
  Future<void> changeUsernameUsersMeUsernamePatch(ChangeUsernameRequest changeUsernameRequest,) async {
    final response = await changeUsernameUsersMeUsernamePatchWithHttpInfo(changeUsernameRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Follow
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<Response> followUsersIdUserIdFollowPostWithHttpInfo(Object userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/id/{user_id}/follow'
      .replaceAll('{user_id}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Follow
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<void> followUsersIdUserIdFollowPost(Object userId,) async {
    final response = await followUsersIdUserIdFollowPostWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get Me
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMeUsersMeGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/users/me';

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

  /// Get Me
  Future<User?> getMeUsersMeGet() async {
    final response = await getMeUsersMeGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
    }
    return null;
  }

  /// Get User Id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<Response> getUserIdUsersIdUserIdGetWithHttpInfo(Object userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/id/{user_id}'
      .replaceAll('{user_id}', userId.toString());

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

  /// Get User Id
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<User?> getUserIdUsersIdUserIdGet(Object userId,) async {
    final response = await getUserIdUsersIdUserIdGetWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
    }
    return null;
  }

  /// Get User Username
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] username (required):
  Future<Response> getUserUsernameUsersUsernameUsernameGetWithHttpInfo(Object username,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/username/{username}'
      .replaceAll('{username}', username.toString());

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

  /// Get User Username
  ///
  /// Parameters:
  ///
  /// * [Object] username (required):
  Future<User?> getUserUsernameUsersUsernameUsernameGet(Object username,) async {
    final response = await getUserUsernameUsersUsernameUsernameGetWithHttpInfo(username,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
    }
    return null;
  }

  /// Unblock
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<Response> unblockUsersIdUserIdUnblockPostWithHttpInfo(Object userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/id/{user_id}/unblock'
      .replaceAll('{user_id}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Unblock
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<void> unblockUsersIdUserIdUnblockPost(Object userId,) async {
    final response = await unblockUsersIdUserIdUnblockPostWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Unfollow
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<Response> unfollowUsersIdUserIdUnfollowPostWithHttpInfo(Object userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/id/{user_id}/unfollow'
      .replaceAll('{user_id}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Unfollow
  ///
  /// Parameters:
  ///
  /// * [Object] userId (required):
  Future<void> unfollowUsersIdUserIdUnfollowPost(Object userId,) async {
    final response = await unfollowUsersIdUserIdUnfollowPostWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
