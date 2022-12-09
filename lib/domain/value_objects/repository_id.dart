import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのIDを表すValueObject
class RepositoryId extends ValueObject<int> {
  RepositoryId(super.value);
}

class RepositoryIdConverter implements JsonConverter<RepositoryId, String> {
  const RepositoryIdConverter();

  @override
  RepositoryId fromJson(String jsonData) {
    return RepositoryId(int.parse(jsonData));
  }

  @override
  String toJson(RepositoryId object) {
    return object.toString();
  }
}
