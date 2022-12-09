import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのWatcher 数
class CountWatcher extends ValueObject<int> {
  CountWatcher(super.value);
}

class CountWatcherConverter implements JsonConverter<CountWatcher, String> {
  const CountWatcherConverter();

  @override
  CountWatcher fromJson(String jsonData) {
    return CountWatcher(int.parse(jsonData));
  }

  @override
  String toJson(CountWatcher object) {
    return object.toString();
  }
}
