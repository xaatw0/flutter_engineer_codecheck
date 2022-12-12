import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:intl/intl.dart';

import '../../../domain/repositories/git_repository.dart';

/// ソート方法に関連するロジックがまとめてある。
/// ソート方法に応じたアイコンとレポジトリのデータを取得するファンクションが取得できる。
class SortMethodLogic {
  /// アイコンとソート方法のマップ
  final _mapIcons = <IconData, List<SortMethod>>{
    Icons.star: [SortMethod.bestMatch, SortMethod.starAsc, SortMethod.starDesc],
    Icons.fork_right: [SortMethod.forkAsc, SortMethod.forkDesc],
    Icons.update: [SortMethod.recentlyUpdated, SortMethod.leastRecentlyUpdate],
  };

  /// ファンクションとソート方法のマップ
  late final _mapFunctions =
      <String Function(GitRepositoryData data), List<SortMethod>>{
    (data) => data.countStar().toString(): [
      SortMethod.bestMatch,
      SortMethod.starAsc,
      SortMethod.starDesc
    ],
    (data) => data.countFork().toString(): [
      SortMethod.forkAsc,
      SortMethod.forkDesc
    ],
    (data) => _dateFormat.format(data.updateTime()).toString(): [
      SortMethod.recentlyUpdated,
      SortMethod.leastRecentlyUpdate
    ],
  };

  SortMethodLogic(this._sortMethod);

  /// ソート方法
  final SortMethod _sortMethod;

  /// 作成日時、更新日時の出力形式
  final _dateFormat = DateFormat('yyyy/MM/dd');

  ///  指定のソート方法に対するアイコンを取得する
  IconData getIcon() {
    return _mapIcons.keys.firstWhere(
      (key) => _mapIcons[key]!.contains(_sortMethod),
    );
  }

  /// 指定のソート方法に対する表示する値を取得するファンクションを取得する
  String Function(GitRepositoryData data) getValue() {
    return _mapFunctions.keys.firstWhere(
      (key) => _mapFunctions[key]!.contains(_sortMethod),
    );
  }
}
