// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/widgets.dart' hide Notification;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thud/models/chat.dart';
import 'package:thud/models/typedefs.dart';

import 'package:thud/api/lib/api.dart';

import 'package:thud/models/auth.dart';
import 'package:thud/models/post.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thud/models/user.dart';

export 'package:thud/api/lib/api.dart';
export 'package:provider/provider.dart';
export 'package:flutter/foundation.dart';

class ThudState with ChangeNotifier {
  final String apiUrl;
  late final ApiClient _apiClient;
  late final AuthApi _authApi;
  late final UsersApi _usersApi;
  late final ContentApi _contentApi;
  late final ChatApi _chatApi;
  late final NotificationApi _notificationApi;

  ThudState({this.apiUrl = 'https://thudapi.georgetian.com:8443'}) {
    _apiClient = ApiClient(basePath: apiUrl);
    _authApi = AuthApi(_apiClient);
    _contentApi = ContentApi(_apiClient);
    _usersApi = UsersApi(_apiClient);
    _chatApi = ChatApi(_apiClient);
    _notificationApi = NotificationApi(_apiClient);
  }

  final posts = <ID, PostProvider>{};
  final users = <ID, UserProvider>{};
  final usernames = <String, ID>{};
  final chats = <ID, ChatProvider>{};
  final notifications = <ID, Notification>{};
  final _notifier = FlutterLocalNotificationsPlugin();

  final _secureStorage = const FlutterSecureStorage();
  final _credentialsKey = 'credentials';
  UserProvider? activeUser;
  Token? _token;

  var _jumpToNotifications = false;
  bool get jumpToNotifications => _jumpToNotifications;
  void jumpedToNotifications() => _jumpToNotifications = false;

  String mediaIdToUrl(ID mediaId) => '$apiUrl/media/$mediaId';

  Future<bool> register(String username, String password) async {
    try {
      await _authApi.registerRegisterPut(
          RegisterRequest(username: username, password: password));
    } on ApiException {
      return false;
    }
    return true;
  }

  Future<Credentials?> getSavedCredentials() async {
    String? credString = await _secureStorage.read(key: _credentialsKey);
    if (credString == null) {
      return null;
    }
    var credentials = Credentials.fromString(credString);
    if (credentials == null) {
      return null;
    }
    return credentials;
  }

  Future<bool> getActiveUser() async {
    var user = await _usersApi.getMeUsersMeGet();
    if (user == null) {
      return false;
    }
    activeUser = UserProvider.fromUser(user);
    users[activeUser!.id] = activeUser!;
    print('Active user:');
    print(activeUser);
    return true;
  }

  void setToken(Token token) {
    _apiClient.addDefaultHeader('Authorization', 'Bearer ${token.accessToken}');
  }

  Future<bool> login({Credentials? credentials, bool save = false}) async {
    await _notifier.initialize(
      const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveNotificationResponse: (details) {
        _jumpToNotifications = true;
        notifyListeners(); 
      },
    );

    _token = null;
    credentials ??= await getSavedCredentials();
    if (credentials == null) {
      return false;
    }
    try {
      _token = await _authApi.loginLoginPost(
          credentials.username, credentials.password);
    } on ApiException {
      return false;
    }
    if (_token == null) {
      return false;
    }
    if (save) {
      await _secureStorage.write(
          key: _credentialsKey, value: credentials.toString());
    }
    setToken(_token!);

    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (activeUser == null) {
        timer.cancel();
        return;
      }
      try {
        var newNotifications =
            await _notificationApi.getNotificationsNotificationsGet();
        if (newNotifications == null) {
          return;
        }
        bool added = false;
        for (final notification in newNotifications.notifications) {
          if (notifications.containsKey(notification.id)) {
            continue;
          }
          added = true;
          notifications[notification.id] = notification;
          await showNotification(notification);
        }
        if (added) {
          notifyListeners();
        }
      } on ApiException {
        return;
      }
    });
    return getActiveUser();
  }

  Future<void> logout() async {
    try {
      await _authApi.logoutLogoutPost();
    } on ApiException {}
    activeUser = null;
    await _secureStorage.delete(key: _credentialsKey);
  }

  Future<bool> createPost({
    required String title,
    required String content,
    String? location,
    List<XFile> media = const [],
    List<String> tags = const [],
  }) async {
    print('creating post');
    print(content);
    CreatePostSuccessResponse? resp;
    try {
      resp = await _contentApi.createPostPostsPut(CreatePostRequest(
        title: title,
        tags: tags,
        content: content,
        location: location,
        mediaCount: media.length,
      ));
    } on ApiException {
      print('create post failed');
      return false;
    }

    if (resp == null) {
      return false;
    }

    for (int i = 0; i < media.length; i++) {
      try {
        await _contentApi.putMediaMediaMediaIdPut(
            resp.media[i], await MultipartFile.fromPath('file', media[i].path));
      } on ApiException {
        print('upload media failed');
        return false;
      }
    }

    return true;
  }

  Future<bool> createComment(ID postId, String content) async {
    try {
      var comment = await _contentApi.createCommentPostsPostIdCommentsPut(
          postId, CreateCommentRequest(content: content));
      if (comment == null) {
        return false;
      }
      posts[postId]!.comments.add(comment);
      posts[postId]!.notifyListeners();
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<String> notificationToString(Notification notification) async {
    var username = (await getUser(notification.sender))!.username;
    String message = '';
    if (notification.type == 'like') {
      message = 'has liked your post';
    } else if (notification.type == 'save') {
      message = 'has saved your post';
    } else if (notification.type == 'comment') {
      message = 'has commented on your post';
    } else if (notification.type == 'follow') {
      message = 'has followed you';
    } else if (notification.type == 'message') {
      message = 'has messaged you';
    } else if (notification.type == 'post') {
      message = 'has created a new post';
    }
    return '$username $message';
  }

  Future<void> showNotification(Notification notification) async {
    await _notifier.show(
      notification.id,
      await notificationToString(notification),
      null,
      NotificationDetails(
        android: AndroidNotificationDetails(
          notification.type.hashCode.toString(),
          notification.type,
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
        ),
      ),
    );
  }

  Future<void> deleteNotification(ID id) async {
    notifications.remove(id);
    await _notificationApi.deleteNotificationNotificationsDelete(
        DeleteNotificationRequest(id: id));
  }

  Future<List<PostProvider>> searchPosts(SearchContentRequest query) async {
    print('query');
    print(query);
    var queriedPosts = await _contentApi.searchPostsPostsPost(query) ?? [];
    for (final post in queriedPosts) {
      if (posts.containsKey(post.id)) {
        posts[post.id]!.update(post);
      } else {
        posts[post.id] = PostProvider.fromPost(post);
      }
    }
    return [for (final post in queriedPosts) posts[post.id]!];
  }

  Future<UserProvider?> getUser(dynamic idOrUsername, {bool refresh = false}) async {
    if (!(idOrUsername is ID || idOrUsername is String)) {
      return null;
    }
    final isId = idOrUsername is ID;

    if (!refresh) {
      var user = isId ? users[idOrUsername] : users[usernames[idOrUsername]];
      if (user != null) {
        return user;
      }
    }

    try {
      var user = await (isId
        ? _usersApi.getUserIdUsersIdUserIdGet(idOrUsername)
        : _usersApi.getUserUsernameUsersUsernameUsernameGet(idOrUsername));
      if (user == null) {
        return null;
      }
      users.containsKey(user.id)
        ? users[user.id]!.update(user)
        : users[user.id] = UserProvider.fromUser(user);
      usernames[user.username] = user.id;
      print(user);
      return users[user.id];
    } on ApiException catch (e) {
      print('getUserException');
      print(e);
      return null;
    }
  }

  Future<PostProvider?> getPost(ID id, {bool refresh = false}) async {
    if (!refresh && posts.containsKey(id)) {
      return posts[id];
    }
    try {
      var post = await _contentApi.getPostPostsPostIdGet(id);
      if (post == null) {
        return null;
      }
      posts.containsKey(id)
        ? posts[id]!.update(post)
        : posts[id] = PostProvider.fromPost(post);
      return posts[id];
    } on ApiException catch (e) {
      print('getPostException');
      print(e);
      return null;
    }
  }

  bool _checkActiveUserAndPost(ID post) {
    if (activeUser == null) {
      print('activeUser == null');
      throw 'User not logged in';
    }
    if (!posts.containsKey(post)) {
      print('!posts.containsKey(post)');
      return false;
    }
    return true;
  }

  bool liked(ID post) {
    if (!_checkActiveUserAndPost(post)) {
      return false;
    }
    return posts[post]!.likers.contains(activeUser!.id);
  }

  bool saved(ID post) {
    if (!_checkActiveUserAndPost(post)) {
      return false;
    }
    return posts[post]!.savers.contains(activeUser!.id);
  }

  Future<bool> like(ID post) async {
    if (!_checkActiveUserAndPost(post)) {
      return false;
    }
    try {
      await _contentApi.likePostsPostIdLikePatch(post);
    } on ApiClient {
      return false;
    }
    posts[post]!.like(activeUser!.id);
    activeUser!.like(post);
    return true;
  }

  Future<bool> unlike(ID post) async {
    if (!_checkActiveUserAndPost(post)) {
      return false;
    }
    try {
      await _contentApi.unlikePostsPostIdUnlikePatch(post);
    } on ApiClient {
      return false;
    }
    posts[post]!.unlike(activeUser!.id);
    activeUser!.unlike(post);
    return true;
  }

  Future<bool> save(ID post) async {
    if (!_checkActiveUserAndPost(post)) {
      return false;
    }
    try {
      await _contentApi.savePostsPostIdSavePatch(post);
    } on ApiClient {
      return false;
    }
    posts[post]!.save(activeUser!.id);
    activeUser!.save(post);
    return true;
  }

  Future<bool> unsave(ID post) async {
    if (!_checkActiveUserAndPost(post)) {
      return false;
    }
    try {
      await _contentApi.unsavePostsPostIdUnsavePatch(post);
    } on ApiClient {
      return false;
    }
    posts[post]!.unsave(activeUser!.id);
    activeUser!.unsave(post);
    return true;
  }

  bool follows(ID user) {
    if (activeUser == null) {
      return false;
    }
    return activeUser!.followees.contains(user);
  }

  Future<bool> follow(ID userId) async {
    if (activeUser == null) {return false;}
    if (follows(userId)) {return false;}
    try {
      await _usersApi.followUsersIdUserIdFollowPost(userId);
      activeUser!.follow(userId);
      (await getUser(userId))?.addFollower(activeUser!.id);
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<bool> unfollow(ID userId) async {
    if (activeUser == null) {return false;}
    if (!follows(userId)) {return false;}
    try {
      await _usersApi.unfollowUsersIdUserIdUnfollowPost(userId);
      activeUser!.unfollow(userId);
      (await getUser(userId))?.removeFollower(activeUser!.id);
      return true;
    } on ApiException {
      return false;
    }
  }

  bool blocks(ID user) {
    if (activeUser == null) {
      return false;
    }
    return activeUser!.blocking.contains(user);
  }

  Future<bool> block(ID userId) async {
    if (activeUser == null) {
      return false;
    }
    try {
      await _usersApi.blockUsersIdUserIdBlockPost(userId);
      activeUser!.block(userId);
      (await getUser(userId))?.notifyListeners();
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<bool> unblock(ID userId) async {
    if (activeUser == null) {
      return false;
    }
    try {
      await _usersApi.unblockUsersIdUserIdUnblockPost(userId);
      activeUser!.unblock(userId);
      (await getUser(userId))?.notifyListeners();
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<void> getMessages() async {
    Chat chat;
    try {
      chat = await _chatApi.getMessagesChatGet() ?? Chat();
    } on ApiException {
      return;
    }
    for (final message in chat.messages) {
      var user =
          message.sender == activeUser!.id ? message.receiver : message.sender;
      if (chats.containsKey(user)) {
        chats[user]!.addMessage(message);
      } else {
        chats[user] = ChatProvider([message], (await getUser(user))!);
      }
    }
  }

  List<ChatProvider> getChatOrder() {
    var orderedChats = chats.values.toList();
    // TODO: error
    if (orderedChats.length > 1) {
      orderedChats.sort((a, b) =>
          a.messages.last.timestamp.isBefore(b.messages.last.timestamp) ? 1 : -1);
    }
    return orderedChats;
  }

  Future<bool> sendMessage(ID receiver, String message) async {
    await _chatApi.sendMessageChatPut(
        SendMessageRequest(receiver: receiver, message: message));
    return true;
  }

  Future<ChatProvider?> getChat({ID? id, String? username}) async {
    var user = await getUser(id ?? username, refresh: true);
    if (user == null) {
      return null;
    }
    if (!chats.containsKey(user.id)) {
      chats[user.id] = ChatProvider([], user);
    }
    return chats[user.id];
  }

  Future<bool> changeUsername(String newUsername) async {
    try {
      await _usersApi.changeUsernameUsersMeUsernamePatch(
        ChangeUsernameRequest(newUsername: newUsername),
      );
      activeUser!.username = newUsername;
      usernames[newUsername] = activeUser!.id;
      activeUser!.notifyListeners();
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      var token = await _usersApi.changePasswordUsersMePasswordPatch(
          ChangePasswordRequest(
              oldPassword: oldPassword, newPassword: newPassword));
      if (token == null) {
        return false;
      }
      setToken(token);
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<bool> changeProfilePicture(XFile profilePicture) async {
    try {
      var id = await _usersApi.changeProfilePictureUsersMeProfilePicturePatch(
          await MultipartFile.fromPath('profile_picture', profilePicture.path));
      if (id == null) {
        return false;
      }
      activeUser!.profilePicture = id.id;
      NetworkImage(mediaIdToUrl(id.id)).evict();
      activeUser!.notifyListeners();
      return true;
    } on ApiException {
      return false;
    }
  }

  Future<bool> changeBio(String bio) async {
    try {
      await _usersApi.changeBioUsersMeBioPatch(
        ChangeBioRequest(bio: bio),
      );
      activeUser!.bio = bio;
      return true;
    } on ApiException {
      return false;
    }
  }
}
