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
import 'owner.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const Item._(); //メソッド不要の場合、削除

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Item({
    required String name,
    required Owner owner,
    String? language,
    required int openIssues,
    required int stargazersCount,
    required int watchers,
    required int forks,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  GitRepositoryData toGitRepositoryData() {
    return GitRepositoryData(
      repositoryName: RepositoryName(name),
      ownerIconUrl: OwnerIconUrl(owner.avatarUrl),
      projectLanguage: ProjectLanguage(language),
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
