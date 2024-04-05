final class SeperatedListGenerate {
  static List<T> generate<T>({
    required int listLength,
    required T Function(int index) itemBuilder,
    required T Function(int index) separatorBuilder,
  }) {
    final items = <T>[];
    for (var i = 0; i < listLength; i++) {
      items.add(itemBuilder(i));
      if (i < listLength - 1) {
        items.add(separatorBuilder(i));
      }
    }
    return items;
  }
}
