extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split(" ")
        .map(
          (word) => word.isEmpty
              ? word
              : "${word[0].toUpperCase()}${word.substring(1)}",
        )
        .join(" ");
  }

  String emptyOn(String other) => (this == other) ? "" : this;
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> joinElements(T separator) {
    if (length <= 1) return this;
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(elementAt(i));
      if (i < length - 1) result.add(separator);
    }
    return result;
  }
}
