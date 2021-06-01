import 'dart:collection';

extension DeepList<E> on List<E> {
  List deepSearchByValue<V>(bool predicate(V value)) {
    var newList = [];
    forEach((element) {
      if (element is List) {
        var newElement = element.deepSearchByValue<V>(predicate);
        if (newElement.isNotEmpty) {
          newList.add(newElement);
        }
      } else if (element is Set) {
        var newElement = element.deepSearchByValue(predicate);
        if (newElement.isNotEmpty) {
          newList.add(newElement);
        }
      } else if (element is Map) {
        var newElement = element.deepSearchByValue(predicate);
        if (newElement.isNotEmpty) {
          newList.add(newElement);
        }
      } else if (element is V && predicate(element)) {
        newList.add(element);
      }
    });

    return newList;
  }
}

extension DeepMap<K, V> on Map<K, V> {
  /// Returns new instance of recursively filtered (by value) [Map].
  Map deepSearchByValue<E>(bool predicate(E value)) =>
      LinkedHashMap.fromIterable(keys,
          key: (k) => k,
          value: (k) {
            if (this[k] is Map) {
              return (this[k] as Map).deepSearchByValue<E>(predicate);
            } else if (this[k] is List) {
              return (this[k] as List).deepSearchByValue<E>(predicate);
            } else if (this[k] is Set) {
              return (this[k] as Set).deepSearchByValue<E>(predicate);
            } else if (this[k] is E && predicate(this[k] as E)) {
              return this[k];
            }
          })
        ..removeWhere(
            (key, value) => value == null || (value is Map && value.isEmpty));
}

extension DeepSet<E> on Set<E> {
  Set deepSearchByValue<V>(bool predicate(V value)) =>
      toList(growable: false).deepSearchByValue<V>(predicate).toSet().cast<E>();
}
