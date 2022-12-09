import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

@freezed

/// GithubApiで取得するデータのownerに対応するデータ
class Owner with _$Owner {
  const Owner._();
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Owner({
    /// 顔のURL
    required String avatarUrl,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}