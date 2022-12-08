import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_description.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';

/// Gitのレポジトリの情報
class GitRepositoryData {
  const GitRepositoryData({
    required this.repositoryName,
    required this.ownerIconUrl,
    required this.projectLanguage,
    required this.repositoryDescription,
    required this.countStar,
    required this.countWatcher,
    required this.countFork,
    required this.countIssue,
  });

  /// 該当リポジトリのリポジトリ名
  final RepositoryName repositoryName;

  /// 該当リポジトリのオーナーアイコン
  final OwnerIconUrl ownerIconUrl;

  /// 該当リポジトリのプロジェクト言語
  final ProjectLanguage projectLanguage;

  /// 該当リポジトリの概要
  final RepositoryDescription repositoryDescription;

  /// 該当リポジトリのStar 数
  final CountStar countStar;

  /// 該当リポジトリのWatcher 数
  final CountWatcher countWatcher;

  /// 該当リポジトリのFork 数
  final CountFork countFork;

  /// 該当リポジトリのIssue 数
  final CountIssue countIssue;
}
