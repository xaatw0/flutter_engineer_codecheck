import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/git_repository.dart';

/// 剣客結果を表示するページのViewModel
class SearchResultPageVm {
  // GitRepositoryのインスタンス
  final _gitRepository = GetIt.I.get<GitRepository>();

  // キーワードに基づいた検索結果を取得するProvider
  late final _searchResultProvider = StateNotifierProvider<SearchResultNotifier,
      AsyncValue<List<GitRepositoryData>>>(
    (ref) => SearchResultNotifier(_gitRepository),
  );

  // キーワードに基づいた検索結果を取得するProviderの状態を管理するAsyncValue
  AsyncValue<List<GitRepositoryData>> get getRepositoryData =>
      _ref.watch(_searchResultProvider);

  late final WidgetRef _ref;
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  /// 検索キーワード
  String _keyword = '';

  /// データ取得が終了したページのインデックス
  int _page = 0;

  /// [keyword]を検索キーワードにして、[page]ページ目の GitRepositoryのデータを取得する。
  /// [isLoadMore] false: 初回取得 true:2回目以降の取得
  void _fetch(String keyword, int page, bool isLoadMore) {
    _ref.read(_searchResultProvider.notifier).fetch(keyword, page, isLoadMore);
  }

  /// [keyword]で初めて検索をする
  void onLoad(String keyword) {
    _keyword = keyword;
    _page = _gitRepository.getFirstPageIndex();
    _fetch(_keyword, _page, false);
  }

  /// [_keyword]を検索キーワードにして、[_page]ページ目の GitRepositoryのデータを取得する。
  void onLoadMore() {
    _page++;
    if (!_ref.read(_searchResultProvider.notifier).isLoading()) {
      _fetch(_keyword, _page, true);
    }
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
