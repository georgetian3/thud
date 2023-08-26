# openapi.api.NotificationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteNotificationNotificationsDelete**](NotificationApi.md#deletenotificationnotificationsdelete) | **DELETE** /notifications/ | Delete Notification
[**getNotificationsNotificationsGet**](NotificationApi.md#getnotificationsnotificationsget) | **GET** /notifications/ | Get Notifications


# **deleteNotificationNotificationsDelete**
> Object deleteNotificationNotificationsDelete(deleteNotificationRequest)

Delete Notification

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NotificationApi();
final deleteNotificationRequest = DeleteNotificationRequest(); // DeleteNotificationRequest | 

try {
    final result = api_instance.deleteNotificationNotificationsDelete(deleteNotificationRequest);
    print(result);
} catch (e) {
    print('Exception when calling NotificationApi->deleteNotificationNotificationsDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteNotificationRequest** | [**DeleteNotificationRequest**](DeleteNotificationRequest.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNotificationsNotificationsGet**
> Notifications getNotificationsNotificationsGet()

Get Notifications

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NotificationApi();

try {
    final result = api_instance.getNotificationsNotificationsGet();
    print(result);
} catch (e) {
    print('Exception when calling NotificationApi->getNotificationsNotificationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Notifications**](Notifications.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

