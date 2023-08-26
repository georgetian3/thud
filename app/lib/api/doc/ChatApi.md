# openapi.api.ChatApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMessagesChatGet**](ChatApi.md#getmessageschatget) | **GET** /chat/ | Get Messages
[**sendMessageChatPut**](ChatApi.md#sendmessagechatput) | **PUT** /chat/ | Send Message


# **getMessagesChatGet**
> Chat getMessagesChatGet()

Get Messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();

try {
    final result = api_instance.getMessagesChatGet();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getMessagesChatGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Chat**](Chat.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendMessageChatPut**
> sendMessageChatPut(sendMessageRequest)

Send Message

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();
final sendMessageRequest = SendMessageRequest(); // SendMessageRequest | 

try {
    api_instance.sendMessageChatPut(sendMessageRequest);
} catch (e) {
    print('Exception when calling ChatApi->sendMessageChatPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendMessageRequest** | [**SendMessageRequest**](SendMessageRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

