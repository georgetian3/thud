import 'package:flutter/foundation.dart';
import 'package:thud/api/lib/api.dart';
import 'package:thud/models/typedefs.dart';


class UserProvider extends User with ChangeNotifier {

  UserProvider({
    required super.id,
    required super.username,
    super.profilePicture,
    required super.dateJoined,
    super.email,
    super.bio,
    super.posts = const [],
    super.comments = const [],
    super.liked = const [],
    super.saved = const [],
    super.followers = const [],
    super.followees = const [],
    super.blocking = const [],
  });

  static UserProvider fromUser(User user) {
    return UserProvider(
      id: user.id,
      username: user.username,
      profilePicture: user.profilePicture,
      dateJoined: user.dateJoined,
      email: user.email,
      bio: user.bio,
      posts: user.posts,
      comments: user.comments,
      liked: user.liked,
      saved: user.saved,
      followers: user.followers,
      followees: user.followees,
      blocking: user.blocking,
    );
  }

  void update(User user) {
    id = user.id;
    username = user.username;
    profilePicture = user.profilePicture;
    dateJoined = user.dateJoined;
    email = user.email;
    bio = user.bio;
    posts = user.posts;
    comments = user.comments;
    liked = user.liked;
    saved = user.saved;
    followers = user.followers;
    followees = user.followees;
    blocking = user.blocking;
    notifyListeners();
  }

  bool like(ID post) {
    if (liked.contains(post)) {
      return false;
    }
    liked.add(post);
    notifyListeners();
    return true;
  }
  bool unlike(ID post) {
    var removed = liked.remove(post);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }
  bool save(ID post) {
    if (saved.contains(post)) {
      return false;
    }
    saved.add(post);
    notifyListeners();
    return true;
  }
  bool unsave(ID post) {
    var removed = saved.remove(post);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }
  bool follow(ID user) {
    if (followees.contains(user)) {
      return false;
    }
    followees.add(user);
    notifyListeners();
    return true;
  }
  bool unfollow(ID user) {
    var removed = followees.remove(user);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }
  bool addFollower(ID user) {
    if (followers.contains(user)) {
      return false;
    }
    followers.add(user);
    notifyListeners();
    return true;
  }
  bool removeFollower(ID user) {
    var removed = followers.remove(user);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }
  bool block(ID user) {
    if (blocking.contains(user)) {
      return false;
    }
    blocking.add(user);
    notifyListeners();
    return true;
  }
  bool unblock(ID user) {
    var removed = blocking.remove(user);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }
}