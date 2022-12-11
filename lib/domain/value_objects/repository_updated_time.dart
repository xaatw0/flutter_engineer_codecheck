import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリの更新日時
class RepositoryUpdateTime extends ValueObject<DateTime> {
  RepositoryUpdateTime(super.value);
}

class RepositoryUpdateTimeConverter
    implements JsonConverter<RepositoryUpdateTime, String> {
  const RepositoryUpdateTimeConverter();

  @override
  RepositoryUpdateTime fromJson(String jsonData) {
    try {
      return RepositoryUpdateTime(DateTime.parse(jsonData));
    } catch (e) {
      throw FormatException('日付のフォーマットが異なる: $jsonData');
    }
  }

  @override
  String toJson(RepositoryUpdateTime object) {
    return object().toUtc().toString();
  }
}
