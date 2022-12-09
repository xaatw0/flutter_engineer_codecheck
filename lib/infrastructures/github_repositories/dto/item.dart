import 'package:flutter_engineer_codecheck/domain/value_objects/repository_description.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_id.dart';
import 'owner.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed

/// GithubApiで取得するデータのitemsのリストに対応するデータ
class Item with _$Item {
  const Item._(); //メソッド不要の場合、削除

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
  }) = _Item;

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
    );
  }
}

class ItemConverter implements JsonConverter<Item, String> {
  const ItemConverter();

  @override
  Item fromJson(String jsonData) {
    return Item.fromJson(json.decode(jsonData));
  }

  @override
  String toJson(Item object) {
    return json.encode(object.toJson());
  }
}
