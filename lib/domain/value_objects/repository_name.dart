import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのリポジトリ名
class RepositoryName extends ValueObject<String> {
  RepositoryName(super.value);
}

class RepositoryNameConverter implements JsonConverter<RepositoryName, String> {
  const RepositoryNameConverter();

  @override
  RepositoryName fromJson(String jsonData) {
    return RepositoryName(jsonData);
  }

  @override
  String toJson(RepositoryName object) {
    return object.toString();
  }
}
