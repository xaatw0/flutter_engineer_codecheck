import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed

/// GithubApiで取得するデータのトップに対応するデータ
class Result with _$Result {
  const Result._();

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Result({
    required int totalCount,
    required bool incompleteResults,
    required List<Item> items,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
