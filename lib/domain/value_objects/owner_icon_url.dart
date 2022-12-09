import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのオーナーアイコン
class OwnerIconUrl extends ValueObject<String> {
  OwnerIconUrl(super.value);
}

class OwnerIconUrlConverter implements JsonConverter<OwnerIconUrl, String> {
  const OwnerIconUrlConverter();

  @override
  OwnerIconUrl fromJson(String jsonData) {
    return OwnerIconUrl(jsonData);
  }

  @override
  String toJson(OwnerIconUrl object) {
    return object.toString();
  }
}
