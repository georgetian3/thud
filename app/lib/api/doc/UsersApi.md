# openapi.api.UsersApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**blockUsersIdUserIdBlockPost**](UsersApi.md#blockusersiduseridblockpost) | **POST** /users/id/{user_id}/block | Block
[**changeBioUsersMeBioPatch**](UsersApi.md#changebiousersmebiopatch) | **PATCH** /users/me/bio | Change Bio
[**changePasswordUsersMePasswordPatch**](UsersApi.md#changepasswordusersmepasswordpatch) | **PATCH** /users/me/password | Change Password
[**changeProfilePictureUsersMeProfilePicturePatch**](UsersApi.md#changeprofilepictureusersmeprofilepicturepatch) | **PATCH** /users/me/profile-picture | Change Profile Picture
[**changeUsernameUsersMeUsernamePatch**](UsersApi.md#changeusernameusersmeusernamepatch) | **PATCH** /users/me/username | Change Username
[**followUsersIdUserIdFollowPost**](UsersApi.md#followusersiduseridfollowpost) | **POST** /users/id/{user_id}/follow | Follow
[**getMeUsersMeGet**](UsersApi.md#getmeusersmeget) | **GET** /users/me | Get Me
[**getUserIdUsersIdUserIdGet**](UsersApi.md#getuseridusersiduseridget) | **GET** /users/id/{user_id} | Get User Id
[**getUserUsernameUsersUsernameUsernameGet**](UsersApi.md#getuserusernameusersusernameusernameget) | **GET** /users/username/{username} | Get User Username
[**unblockUsersIdUserIdUnblockPost**](UsersApi.md#unblockusersiduseridunblockpost) | **POST** /users/id/{user_id}/unblock | Unblock
[**unfollowUsersIdUserIdUnfollowPost**](UsersApi.md#unfollowusersiduseridunfollowpost) | **POST** /users/id/{user_id}/unfollow | Unfollow


# **blockUsersIdUserIdBlockPost**
> blockUsersIdUserIdBlockPost(userId)

Block

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final userId = ; // Object | 

try {
    api_instance.blockUsersIdUserIdBlockPost(userId);
} catch (e) {
    print('Exception when calling UsersApi->blockUsersIdUserIdBlockPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changeBioUsersMeBioPatch**
> changeBioUsersMeBioPatch(changeBioRequest)

Change Bio

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final changeBioRequest = ChangeBioRequest(); // ChangeBioRequest | 

try {
    api_instance.changeBioUsersMeBioPatch(changeBioRequest);
} catch (e) {
    print('Exception when calling UsersApi->changeBioUsersMeBioPatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changeBioRequest** | [**ChangeBioRequest**](ChangeBioRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changePasswordUsersMePasswordPatch**
> Token changePasswordUsersMePasswordPatch(changePasswordRequest)

Change Password

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final changePasswordRequest = ChangePasswordRequest(); // ChangePasswordRequest | 

try {
    final result = api_instance.changePasswordUsersMePasswordPatch(changePasswordRequest);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->changePasswordUsersMePasswordPatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

[**Token**](Token.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changeProfilePictureUsersMeProfilePicturePatch**
> ProfilePictureId changeProfilePictureUsersMeProfilePicturePatch(profilePicture)

Change Profile Picture

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final profilePicture = ; // Object | 

try {
    final result = api_instance.changeProfilePictureUsersMeProfilePicturePatch(profilePicture);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->changeProfilePictureUsersMeProfilePicturePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **profilePicture** | [**Object**](Object.md)|  | 

### Return type

[**ProfilePictureId**](ProfilePictureId.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changeUsernameUsersMeUsernamePatch**
> changeUsernameUsersMeUsernamePatch(changeUsernameRequest)

Change Username

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final changeUsernameRequest = ChangeUsernameRequest(); // ChangeUsernameRequest | 

try {
    api_instance.changeUsernameUsersMeUsernamePatch(changeUsernameRequest);
} catch (e) {
    print('Exception when calling UsersApi->changeUsernameUsersMeUsernamePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changeUsernameRequest** | [**ChangeUsernameRequest**](ChangeUsernameRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **followUsersIdUserIdFollowPost**
> followUsersIdUserIdFollowPost(userId)

Follow

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final userId = ; // Object | 

try {
    api_instance.followUsersIdUserIdFollowPost(userId);
} catch (e) {
    print('Exception when calling UsersApi->followUsersIdUserIdFollowPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMeUsersMeGet**
> User getMeUsersMeGet()

Get Me

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();

try {
    final result = api_instance.getMeUsersMeGet();
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getMeUsersMeGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserIdUsersIdUserIdGet**
> User getUserIdUsersIdUserIdGet(userId)

Get User Id

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final userId = ; // Object | 

try {
    final result = api_instance.getUserIdUsersIdUserIdGet(userId);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getUserIdUsersIdUserIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | [**Object**](.md)|  | 

### Return type

[**User**](User.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserUsernameUsersUsernameUsernameGet**
> User getUserUsernameUsersUsernameUsernameGet(username)

Get User Username

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final username = ; // Object | 

try {
    final result = api_instance.getUserUsernameUsersUsernameUsernameGet(username);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getUserUsernameUsersUsernameUsernameGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | [**Object**](.md)|  | 

### Return type

[**User**](User.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unblockUsersIdUserIdUnblockPost**
> unblockUsersIdUserIdUnblockPost(userId)

Unblock

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final userId = ; // Object | 

try {
    api_instance.unblockUsersIdUserIdUnblockPost(userId);
} catch (e) {
    print('Exception when calling UsersApi->unblockUsersIdUserIdUnblockPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unfollowUsersIdUserIdUnfollowPost**
> unfollowUsersIdUserIdUnfollowPost(userId)

Unfollow

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();
final userId = ; // Object | 

try {
    api_instance.unfollowUsersIdUserIdUnfollowPost(userId);
} catch (e) {
    print('Exception when calling UsersApi->unfollowUsersIdUserIdUnfollowPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

