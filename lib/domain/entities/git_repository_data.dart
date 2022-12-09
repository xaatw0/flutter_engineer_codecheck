import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_description.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'git_repository_data.freezed.dart';
part 'git_repository_data.g.dart';

@freezed
class GitRepositoryData with _$GitRepositoryData {
  const GitRepositoryData._(); //メソッド不要の場合、削除
  const factory GitRepositoryData({
    /// 該当リポジトリのリポジトリ名
    @RepositoryNameConverter() required RepositoryName repositoryName,

    /// 該当リポジトリのオーナーアイコン
    @OwnerIconUrlConverter() required OwnerIconUrl ownerIconUrl,

    /// 該当リポジトリのプロジェクト言語
    @ProjectLanguageConverter() required ProjectLanguage projectLanguage,

    /// 該当リポジトリの概要
    @RepositoryDescriptionConverter()
        required RepositoryDescription repositoryDescription,

    /// 該当リポジトリのStar 数
    @CountStarConverter() required CountStar countStar,

    /// 該当リポジトリのWatcher 数
    @CountWatcherConverter() required CountWatcher countWatcher,

    /// 該当リポジトリのFork 数
    @CountForkConverter() required CountFork countFork,

    /// 該当リポジトリのIssue 数
    @CountIssueConverter() required CountIssue countIssue,
  }) = _GitRepositoryData;

  factory GitRepositoryData.fromJson(Map<String, dynamic> json) =>
      _$GitRepositoryDataFromJson(json);
}
