//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/auth_api.dart';
part 'api/chat_api.dart';
part 'api/content_api.dart';
part 'api/notification_api.dart';
part 'api/users_api.dart';

part 'model/change_bio_request.dart';
part 'model/change_password_request.dart';
part 'model/change_username_request.dart';
part 'model/chat.dart';
part 'model/comment.dart';
part 'model/create_comment_request.dart';
part 'model/create_post_request.dart';
part 'model/create_post_success_response.dart';
part 'model/delete_notification_request.dart';
part 'model/http_validation_error.dart';
part 'model/message.dart';
part 'model/notification.dart';
part 'model/notifications.dart';
part 'model/post.dart';
part 'model/profile_picture_id.dart';
part 'model/register_request.dart';
part 'model/search_content_request.dart';
part 'model/send_message_request.dart';
part 'model/token.dart';
part 'model/user.dart';
part 'model/validation_error.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
