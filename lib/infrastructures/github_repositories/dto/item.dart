import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_engineer_codecheck/domain/repository_data_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'owner.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed

/// GithubApiで取得するデータのitemsのリストに対応するデータ
class Item with _$Item {
  //メソッド不要の場合、削除

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Item({
    /// レポジトリID
    required int id,

    /// レポジトリ名
    required String name,

    /// オーナー除法
    required Owner owner,

    /// 言語(存在しない場合もある)
    String? language,

    /// 概略(存在しない場合もある)
    String? description,

    /// イシュー数
    required int openIssues,

    /// スター数
    required int stargazersCount,

    /// ウォッチ数
    required int watchers,

    /// フォーク数
    required int forks,

    /// レポジトリのHtmlへのリンク
    required String htmlUrl,

    /// レポジトリの作成日時
    required String createdAt,

    /// レポジトリの更新日時
    required String updatedAt,
  }) = _Item;

  const Item._();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  GitRepositoryData toGitRepositoryData() {
    return GitRepositoryData(
      repositoryId: RepositoryId(id),
      repositoryName: RepositoryName(name),
      ownerIconUrl: OwnerIconUrl(owner.avatarUrl),
      projectLanguage: ProjectLanguage(language),
      repositoryDescription: RepositoryDescription(description),
      countStar: CountStar(stargazersCount),
      countWatcher: CountWatcher(watchers),
      countFork: CountFork(forks),
      countIssue: CountIssue(openIssues),
      repositoryHtmlUrl: RepositoryHtmlUrl(htmlUrl),
      createTime: const RepositoryCreateTimeConverter().fromJson(createdAt),
      updateTime: const RepositoryUpdateTimeConverter().fromJson(updatedAt),
    );
  }
}

class ItemConverter implements JsonConverter<Item, String> {
  const ItemConverter();

  @override
  Item fromJson(String jsonData) {
    return Item.fromJson(json.decode(jsonData) as Map<String, dynamic>);
  }

  @override
  String toJson(Item object) {
    return json.encode(object.toJson());
  }
}
