import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリの作成日時
class RepositoryCreateTime extends ValueObject<DateTime> {
  RepositoryCreateTime(super.value);
}

class RepositoryCreateTimeConverter
    implements JsonConverter<RepositoryCreateTime, String> {
  const RepositoryCreateTimeConverter();

  @override
  RepositoryCreateTime fromJson(String jsonData) {
    try {
      return RepositoryCreateTime(DateTime.parse(jsonData));
    } on Exception catch (_) {
      throw FormatException('日付のフォーマットが異なる: $jsonData');
    }
  }

  @override
  String toJson(RepositoryCreateTime object) {
    return object().toUtc().toString();
  }
}
