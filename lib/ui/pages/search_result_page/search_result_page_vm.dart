import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/string_resources.dart';
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_notifier.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/sort_method_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/git_repository.dart';

/// 選択したソート方法に基づき、RepositoryDataCard のアイコンと表示する項目を管理するロジックのProvider。
/// 選択したソート方法をこのクラスで設定するため、ここに定義している。
final sortMethodProvider = StateProvider(
  (ref) => SortMethodLogic(SortMethod.bestMatch),
);

/// 剣客結果を表示するページのViewModel
class SearchResultPageVm {
  // キーワードに基づいた検索結果を取得するProvider
  late final _searchResultProvider = StateNotifierProvider<SearchResultNotifier,
      AsyncValue<List<GitRepositoryData>>>(
    (ref) => SearchResultNotifier(keyword: _keyword, sortMethod: _sortMethod),
  );

  // キーワードに基づいた検索結果を取得するProviderの状態を管理するAsyncValue
  AsyncValue<List<GitRepositoryData>> get getRepositoryData =>
      _ref.watch(_searchResultProvider);

  late final WidgetRef _ref;
  // ignore: use_setters_to_change_properties
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  /// 検索キーワード
  String _keyword = StringResources.kEmpty;

  /// ソート方法
  SortMethod _sortMethod = SortMethod.bestMatch;

  /// [isLoadMoreData] false: 初回取得 true:2回目以降の取得
  void _fetch(
    bool isLoadMoreData,
  ) {
    _ref
        .read(_searchResultProvider.notifier)
        .fetch(isLoadMoreData: isLoadMoreData);
  }

  /// [keyword]で初めて検索をする。[sortMethod]でソート方法を指定する。
  /// ロードが完了後実施したいファンクションを返す。
  void Function() onLoad(String keyword, SortMethod sortMethod) {
    _keyword = keyword;
    _sortMethod = sortMethod;
    _fetch(false);

    return () => _ref.read(sortMethodProvider.notifier).state =
        SortMethodLogic(sortMethod);
  }

  /// GitRepositoryのデータを取得する。
  void onLoadMore() {
    if (_ref.read(_searchResultProvider.notifier).isLoading()) {
      return;
    }

    _fetch(true);
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
