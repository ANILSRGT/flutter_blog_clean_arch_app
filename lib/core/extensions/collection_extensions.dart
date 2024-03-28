extension CollectionExt<T> on Iterable<T>? {
  T? firstWhereOrNull(bool Function(T element) test) {
    if (this == null) return null;
    for (var element in this!) {
      if (test(element)) return element;
    }
    return null;
  }
}
