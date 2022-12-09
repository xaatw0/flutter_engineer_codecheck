import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result-notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/git_repository.dart';

/// 剣客結果を表示するページのViewModel
class SearchResultPageVm {
  // キーワードに基づいた検索結果を取得するProvider
  final _searchResultProvider = StateNotifierProvider<SearchResultNotifier,
      AsyncValue<List<GitRepositoryData>>>(
    (ref) => SearchResultNotifier(
      GetIt.I.get<GitRepository>(),
    ),
  );

  // キーワードに基づいた検索結果を取得するProviderの状態を管理するAsyncValue
  AsyncValue<List<GitRepositoryData>> get getRepositoryData =>
      _ref.watch(_searchResultProvider);

  late final WidgetRef _ref;
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  String _keyword = '';
  int _page = 0;

  void _fetch(String keyword, int page, bool isLoadMore) {
    _ref.read(_searchResultProvider.notifier).fetch(keyword, page, isLoadMore);
  }

  void onLoad(String keyword) {
    _keyword = keyword;
    _fetch(_keyword, 1, false);
  }

  void onLoadMore() {}

  /// レポジトリのカードが押下されたら、レポジトリ詳細画面に遷移する
  void onRepositoryTapped(
    BuildContext context,
    GitRepositoryData gitRepositoryData,
  ) {
    GoRouter.of(context)
        .push(RepositoryDetailPage.path, extra: gitRepositoryData);
  }
}
