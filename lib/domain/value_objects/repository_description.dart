import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// レポジトリの概要を表すValueObject
class RepositoryDescription extends ValueObject<String?> {
  const RepositoryDescription(super.value);
}

class RepositoryDescriptionConverter
    implements JsonConverter<RepositoryDescription, String> {
  const RepositoryDescriptionConverter();

  @override
  RepositoryDescription fromJson(String jsonData) {
    return RepositoryDescription(jsonData);
  }

  @override
  String toJson(RepositoryDescription object) {
    return object.toString();
  }
}
