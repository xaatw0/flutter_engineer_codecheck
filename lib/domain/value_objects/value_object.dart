/// ValueObject の基底クラス
abstract class ValueObject<T> {
  const ValueObject(this.value);
  final T value;
  T call() {
    return value;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == runtimeType) {
      return (other as ValueObject).value == value;
    }

    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '$runtimeType[$value]';
  }
}
