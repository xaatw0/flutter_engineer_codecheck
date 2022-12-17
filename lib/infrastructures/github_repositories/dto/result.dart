import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed

/// GithubApiで取得するデータのトップに対応するデータ
class Result with _$Result {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Result({
    @Default(-1) int totalCount,
    @Default(false) bool incompleteResults,
    @Default(<Item>[]) List<Item> items,
    String? message,
  }) = _Result;

  const Result._();

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
