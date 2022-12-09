import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのFork 数
class CountFork extends ValueObject<int> {
  CountFork(super.value);
}

class CountForkConverter implements JsonConverter<CountFork, String> {
  const CountForkConverter();

  @override
  CountFork fromJson(String jsonData) {
    return CountFork(int.parse(jsonData));
  }

  @override
  String toJson(CountFork object) {
    return object.toString();
  }
}
