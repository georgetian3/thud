# openapi.api.ContentApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createCommentPostsPostIdCommentsPut**](ContentApi.md#createcommentpostspostidcommentsput) | **PUT** /posts/{post_id}/comments | Create Comment
[**createPostPostsPut**](ContentApi.md#createpostpostsput) | **PUT** /posts | Create Post
[**getMediaMediaMediaIdGet**](ContentApi.md#getmediamediamediaidget) | **GET** /media/{media_id} | Get Media
[**getMediaMediaMediaIdGet_0**](ContentApi.md#getmediamediamediaidget_0) | **HEAD** /media/{media_id} | Get Media
[**getPostPostsPostIdGet**](ContentApi.md#getpostpostspostidget) | **GET** /posts/{post_id} | Get Post
[**likePostsPostIdLikePatch**](ContentApi.md#likepostspostidlikepatch) | **PATCH** /posts/{post_id}/like | Like
[**putMediaMediaMediaIdPut**](ContentApi.md#putmediamediamediaidput) | **PUT** /media/{media_id} | Put Media
[**savePostsPostIdSavePatch**](ContentApi.md#savepostspostidsavepatch) | **PATCH** /posts/{post_id}/save | Save
[**searchPostsPostsPost**](ContentApi.md#searchpostspostspost) | **POST** /posts/ | Search Posts
[**unlikePostsPostIdUnlikePatch**](ContentApi.md#unlikepostspostidunlikepatch) | **PATCH** /posts/{post_id}/unlike | Unlike
[**unsavePostsPostIdUnsavePatch**](ContentApi.md#unsavepostspostidunsavepatch) | **PATCH** /posts/{post_id}/unsave | Unsave


# **createCommentPostsPostIdCommentsPut**
> Comment createCommentPostsPostIdCommentsPut(postId, createCommentRequest)

Create Comment

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final postId = ; // Object | 
final createCommentRequest = CreateCommentRequest(); // CreateCommentRequest | 

try {
    final result = api_instance.createCommentPostsPostIdCommentsPut(postId, createCommentRequest);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->createCommentPostsPostIdCommentsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | [**Object**](.md)|  | 
 **createCommentRequest** | [**CreateCommentRequest**](CreateCommentRequest.md)|  | 

### Return type

[**Comment**](Comment.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPostPostsPut**
> CreatePostSuccessResponse createPostPostsPut(createPostRequest)

Create Post

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final createPostRequest = CreatePostRequest(); // CreatePostRequest | 

try {
    final result = api_instance.createPostPostsPut(createPostRequest);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->createPostPostsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPostRequest** | [**CreatePostRequest**](CreatePostRequest.md)|  | 

### Return type

[**CreatePostSuccessResponse**](CreatePostSuccessResponse.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMediaMediaMediaIdGet**
> Object getMediaMediaMediaIdGet(mediaId)

Get Media

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ContentApi();
final mediaId = ; // Object | 

try {
    final result = api_instance.getMediaMediaMediaIdGet(mediaId);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->getMediaMediaMediaIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mediaId** | [**Object**](.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMediaMediaMediaIdGet_0**
> Object getMediaMediaMediaIdGet_0(mediaId)

Get Media

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ContentApi();
final mediaId = ; // Object | 

try {
    final result = api_instance.getMediaMediaMediaIdGet_0(mediaId);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->getMediaMediaMediaIdGet_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mediaId** | [**Object**](.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostPostsPostIdGet**
> Post getPostPostsPostIdGet(postId)

Get Post

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ContentApi();
final postId = ; // Object | 

try {
    final result = api_instance.getPostPostsPostIdGet(postId);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->getPostPostsPostIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | [**Object**](.md)|  | 

### Return type

[**Post**](Post.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **likePostsPostIdLikePatch**
> likePostsPostIdLikePatch(postId)

Like

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final postId = ; // Object | 

try {
    api_instance.likePostsPostIdLikePatch(postId);
} catch (e) {
    print('Exception when calling ContentApi->likePostsPostIdLikePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putMediaMediaMediaIdPut**
> Object putMediaMediaMediaIdPut(mediaId, file)

Put Media

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final mediaId = ; // Object | 
final file = ; // Object | 

try {
    final result = api_instance.putMediaMediaMediaIdPut(mediaId, file);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->putMediaMediaMediaIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mediaId** | [**Object**](.md)|  | 
 **file** | [**Object**](Object.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **savePostsPostIdSavePatch**
> savePostsPostIdSavePatch(postId)

Save

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final postId = ; // Object | 

try {
    api_instance.savePostsPostIdSavePatch(postId);
} catch (e) {
    print('Exception when calling ContentApi->savePostsPostIdSavePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPostsPostsPost**
> Object searchPostsPostsPost(searchContentRequest)

Search Posts

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final searchContentRequest = SearchContentRequest(); // SearchContentRequest | 

try {
    final result = api_instance.searchPostsPostsPost(searchContentRequest);
    print(result);
} catch (e) {
    print('Exception when calling ContentApi->searchPostsPostsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchContentRequest** | [**SearchContentRequest**](SearchContentRequest.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unlikePostsPostIdUnlikePatch**
> unlikePostsPostIdUnlikePatch(postId)

Unlike

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final postId = ; // Object | 

try {
    api_instance.unlikePostsPostIdUnlikePatch(postId);
} catch (e) {
    print('Exception when calling ContentApi->unlikePostsPostIdUnlikePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unsavePostsPostIdUnsavePatch**
> unsavePostsPostIdUnsavePatch(postId)

Unsave

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ContentApi();
final postId = ; // Object | 

try {
    api_instance.unsavePostsPostIdUnsavePatch(postId);
} catch (e) {
    print('Exception when calling ContentApi->unsavePostsPostIdUnsavePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | [**Object**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

