// import 'package:flutter/material.dart';
// import 'package:thud/models/typedefs.dart';
// import 'package:thud/models/comment.dart';

// class Post with ChangeNotifier {

//   final ID id;
//   final List<String> tags;
//   final List<String> media;
//   final ID creatorId;
//   final String Post;
//   final String title;
//   final List<Comment> comments;
//   final List<ID> likers;
//   final List<ID> savers;
//   final DateTime dateCreated;


//   Post({
//     required super.id,
//     required super.creatorId,
//     required super.dateCreated,
//     required super.Post,
//     required super.commentIds,
//     required super.descendentCount,
//     required super.likers,
//     required super.savers,
//     required super.title,
//     required super.tags,
//   });

// }


// // class PostOrder extends EntityOrder<Post> {

// //   PostOrder(
// //     List<ID> postIds,
// //   ) : super(postIds, 
// //     {
// //       SortMethod.best: (Post a, Post b) {
// //         var cmp = a.likers.length - b.likers.length;
// //         return cmp.toDouble();
// //       },
// //       SortMethod.newest: (Post a, Post b) {
// //         var cmp = b.dateCreated.microsecondsSinceEpoch - a.dateCreated.microsecondsSinceEpoch;
// //         return cmp.toDouble();
// //       },
// //       SortMethod.hot: (Post a, Post b) {
// //         return a.hotness() - b.hotness();
// //       },
// //       SortMethod.random: (Post a, Post b) => 0,
// //     }
// //   );
// // }

import 'package:flutter/foundation.dart';
import 'package:thud/api/lib/api.dart';
import 'package:thud/models/typedefs.dart';

class PostProvider extends Post with ChangeNotifier {
  PostProvider({
    required super.id,
    required super.creator,
    required super.title,
    required super.content,
    required super.dateCreated,
    super.location,
    super.tags = const [],
    super.media = const [],
    super.comments = const [],
    super.likers = const [],
    super.savers = const [],
  });

  static PostProvider fromPost(Post post) {
    return PostProvider(
      id: post.id,
      creator: post.creator,
      title: post.title,
      content: post.content,
      location: post.location,
      dateCreated: post.dateCreated,
      tags: post.tags,
      media: post.media,
      comments: List.from(post.comments),
      likers: post.likers,
      savers: post.savers,
    );
  }

  void update(Post post) {
    if (this == post) {
      return;
    }
    id = post.id;
    creator = post.creator;
    title = post.title;
    content = post.content;
    location = post.location;
    dateCreated = post.dateCreated;
    tags = post.tags;
    media = post.media;
    comments = post.comments;
    likers = post.likers;
    savers = post.savers;
    notifyListeners();
  }

  bool like(ID user) {
    if (likers.contains(user)) {
      return false;
    }
    likers.add(user);
    notifyListeners();
    return true;
  }

  bool unlike(ID user) {
    var removed = likers.remove(user);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

  bool save(ID user) {
    if (savers.contains(user)) {
      return false;
    }
    savers.add(user);
    notifyListeners();
    return true;
  }

  bool unsave(ID user) {
    var removed = savers.remove(user);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

}