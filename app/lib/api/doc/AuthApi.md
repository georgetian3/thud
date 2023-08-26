# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**loginLoginPost**](AuthApi.md#loginloginpost) | **POST** /login | Login
[**logoutLogoutPost**](AuthApi.md#logoutlogoutpost) | **POST** /logout | Logout
[**registerRegisterPut**](AuthApi.md#registerregisterput) | **PUT** /register | Register


# **loginLoginPost**
> Token loginLoginPost(username, password, grantType, scope, clientId, clientSecret)

Login

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final username = ; // Object | 
final password = ; // Object | 
final grantType = ; // Object | 
final scope = ; // Object | 
final clientId = ; // Object | 
final clientSecret = ; // Object | 

try {
    final result = api_instance.loginLoginPost(username, password, grantType, scope, clientId, clientSecret);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->loginLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | [**Object**](Object.md)|  | 
 **password** | [**Object**](Object.md)|  | 
 **grantType** | [**Object**](Object.md)|  | [optional] 
 **scope** | [**Object**](Object.md)|  | [optional] [default to ]
 **clientId** | [**Object**](Object.md)|  | [optional] 
 **clientSecret** | [**Object**](Object.md)|  | [optional] 

### Return type

[**Token**](Token.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logoutLogoutPost**
> logoutLogoutPost()

Logout

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AuthApi();

try {
    api_instance.logoutLogoutPost();
} catch (e) {
    print('Exception when calling AuthApi->logoutLogoutPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerRegisterPut**
> Object registerRegisterPut(registerRequest)

Register

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final registerRequest = RegisterRequest(); // RegisterRequest | 

try {
    final result = api_instance.registerRegisterPut(registerRequest);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->registerRegisterPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRequest** | [**RegisterRequest**](RegisterRequest.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

