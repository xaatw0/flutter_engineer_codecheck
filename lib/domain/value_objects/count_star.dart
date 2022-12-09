import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのStar 数
class CountStar extends ValueObject<int> {
  CountStar(super.value);
}

class CountStarConverter implements JsonConverter<CountStar, String> {
  const CountStarConverter();

  @override
  CountStar fromJson(String jsonData) {
    return CountStar(int.parse(jsonData));
  }

  @override
  String toJson(CountStar object) {
    return object.toString();
  }
}
