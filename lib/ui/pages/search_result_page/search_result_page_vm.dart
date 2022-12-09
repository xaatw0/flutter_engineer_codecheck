import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/git_repository.dart';

/// 剣客結果を表示するページのViewModel
class SearchResultPageVm {
  // キーワードに基づいた検索結果を取得するProvider
  final _repositoryData = FutureProvider.autoDispose
      .family<List<GitRepositoryData>, String>((ref, keyword) async {
    final result = GetIt.I.get<GitRepository>().search(keyword);
    return result;
  });

  // キーワードに基づいた検索結果を取得するProviderの状態を管理するAsyncValue
  AsyncValue<List<GitRepositoryData>> getRepositoryData(String keyword) =>
      _ref.watch(_repositoryData(keyword));

  late final WidgetRef _ref;
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  /// レポジトリのカードが押下されたら、レポジトリ詳細画面に遷移する
  void onRepositoryTapped(
    BuildContext context,
    GitRepositoryData gitRepositoryData,
  ) {
    GoRouter.of(context)
        .push(RepositoryDetailPage.path, extra: gitRepositoryData);
  }
}
