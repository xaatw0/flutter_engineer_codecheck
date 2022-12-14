import 'package:flutter_engineer_codecheck/domain/repository_data_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'git_repository_data.freezed.dart';
part 'git_repository_data.g.dart';

@freezed
class GitRepositoryData with _$GitRepositoryData {
  //メソッド不要の場合、削除
  const factory GitRepositoryData({
    /// 該当リポジトリのリポジトリID
    @RepositoryIdConverter() required RepositoryId repositoryId,

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

    /// 該当レポジトリの作成日時
    @RepositoryCreateTimeConverter() required RepositoryCreateTime createTime,

    /// 該当レポジトリの更新日時
    @RepositoryUpdateTimeConverter() required RepositoryUpdateTime updateTime,
  }) = _GitRepositoryData;

  const GitRepositoryData._();

  factory GitRepositoryData.fromJson(Map<String, dynamic> json) =>
      _$GitRepositoryDataFromJson(json);
}
