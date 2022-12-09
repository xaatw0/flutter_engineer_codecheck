import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのIssue 数
class CountIssue extends ValueObject<int> {
  CountIssue(super.value);
}

class CountIssueConverter implements JsonConverter<CountIssue, String> {
  const CountIssueConverter();

  @override
  CountIssue fromJson(String jsonData) {
    return CountIssue(int.parse(jsonData));
  }

  @override
  String toJson(CountIssue object) {
    return object.toString();
  }
}
