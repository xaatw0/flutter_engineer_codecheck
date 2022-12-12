import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

@freezed

/// GithubApiで取得するデータのownerに対応するデータ
class Owner with _$Owner {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Owner({
    /// 顔のURL
    required String avatarUrl,
  }) = _Owner;

  const Owner._();

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
