import 'package:thud/models/typedefs.dart';
import 'package:flutter/foundation.dart';

class Content with ChangeNotifier {

  final ID id;
  final ID creator;
  final DateTime dateCreated;
  String content;
  Set<ID> comments;
  Set<ID> likers;
  Set<ID> savers;

  Content({
    required this.id,
    required this.creator,
    required this.content,
    required this.dateCreated,
    required this.comments,
    required this.likers,
    required this.savers,
  });

}