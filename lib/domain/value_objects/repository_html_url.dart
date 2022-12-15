import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// レポジトリのURLを表すValueObject
class RepositoryHtmlUrl extends ValueObject<String?> {
  const RepositoryHtmlUrl(super.value);
}

class RepositoryHtmlUrlConverter
    implements JsonConverter<RepositoryHtmlUrl, String> {
  const RepositoryHtmlUrlConverter();

  @override
  RepositoryHtmlUrl fromJson(String jsonData) {
    return RepositoryHtmlUrl(jsonData);
  }

  @override
  String toJson(RepositoryHtmlUrl object) {
    return object.toString();
  }
}
