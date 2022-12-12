/// ValueObject の基底クラス
abstract class ValueObject<T> {
  const ValueObject(this.value);
  final T value;
  T call() {
    return value;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other.runtimeType == runtimeType &&
        other is ValueObject &&
        other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '$runtimeType[$value]';
  }
}
