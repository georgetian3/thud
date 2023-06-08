import 'package:flutter/material.dart';
import 'package:thud/models/typedefs.dart';
import 'dart:math';

enum SortMethod {
  random('random'),
  best('best'),
  newest('new'),
  hot('hot');

  final String sortMethodString;
  const SortMethod(this.sortMethodString);
  @override
  String toString() => sortMethodString;

}


class EntityOrder<T> with ChangeNotifier {

  final rng = Random();
  List<ID> ids;
  SortMethod sortMethod = SortMethod.hot;
  Map<SortMethod, double Function(T, T)> sortCmps;
  Set<SortMethod> get sortMethods => sortCmps.keys.toSet();

  EntityOrder(this.ids, this.sortCmps);

  Future<void> add(List<ID> ids, Map<ID, T> entities) async {
    if (ids.isEmpty) {
      return;
    }
    ids.addAll(ids);
    ids = ids.toSet().toList();
    await sort(entities);
    notifyListeners();
  }


  int get length => ids.length;


  ID? getIdAtIndex(int index) {
    if (index < 0 || index >= ids.length) {
      print('BAD INDEX');
      return null;
    }
    return ids[index];
  }


  void shuffle() => ids.shuffle();


  Future<void> sort(Map<ID, T> entities, {SortMethod? newSortMethod, bool ascending = true}) async {

    if (newSortMethod != null && sortCmps.containsKey(newSortMethod)) {
      sortMethod = newSortMethod;
    }

    var oldOrder = ids;

    print('Sorting by $sortMethod');

    if (sortMethod == SortMethod.random) {
      shuffle();
    } else {
      var entitySubset = <ID, T>{};

      // check for deleted entities
      for (ID id in ids) {
        T? entity = entities[id];
        if (entity != null) {
          entitySubset[id] = entity;
        }
      }

      ids = entitySubset.keys.toList();

      ids.sort((a, b) {
        // ignore: null_check_on_nullable_type_parameter
        T entityA = entitySubset[a]!;
        // ignore: null_check_on_nullable_type_parameter
        T entityB = entitySubset[b]!;
        double cmp = sortCmps[sortMethod]!(entityA, entityB);
        cmp = ascending ? cmp : -cmp;
        int intCmp = cmp > 0 ? 1 : cmp < 0 ? -1 : 0;
        return intCmp;
      });
    }
    if (oldOrder != ids) {
      notifyListeners();
    }
    
  }

  void clear() => ids.clear();

}