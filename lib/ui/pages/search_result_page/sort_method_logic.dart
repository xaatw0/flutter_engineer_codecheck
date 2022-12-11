import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:intl/intl.dart';

import '../../../domain/repositories/git_repository.dart';

class SortMethodLogic {
  final _mapIcons = <IconData, List<SortMethod>>{
    Icons.star: [SortMethod.bestMatch, SortMethod.starAsc, SortMethod.starDesc],
    Icons.fork_right: [SortMethod.forkAsc, SortMethod.forkDesc],
    Icons.update: [SortMethod.recentlyUpdated, SortMethod.leastRecentlyUpdate],
  };

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

  /// ソート方法
  SortMethod _sortMethod = SortMethod.bestMatch;

  /// 作成日時、更新日時の出力形式
  final _dateFormat = DateFormat('yyyy/MM/dd');

  /// ソート方法を設定する
  void setSortMethod(SortMethod sortMethod) {
    _sortMethod = sortMethod;
  }

  ///  指定のソート方法に対するアイコンを取得する
  IconData getIcon() {
    return _mapIcons.keys
        .firstWhere((e) => _mapIcons[e]!.contains(_sortMethod));
  }

  /// 指定のソート方法に対する表示する値を取得するファンクションを取得する
  String Function(GitRepositoryData data) getValue() {
    return _mapFunctions.keys
        .firstWhere((e) => _mapFunctions[e]!.contains(_sortMethod));
  }
}
