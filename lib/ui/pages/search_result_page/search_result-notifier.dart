import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索結果を表示するためのStateNotifier
/// (参考) https://www.zeroichi.biz/blog/1525/
class SearchResultNotifier
    extends StateNotifier<AsyncValue<List<GitRepositoryData>>> {
  SearchResultNotifier(this.repository)
      : super(const AsyncLoading<List<GitRepositoryData>>()) {}

  final GitRepository repository;

  /// データの読込
  Future<void> fetch(String keyword, int page, bool isLoadMore) async {
    state = await AsyncValue.guard(() async {
      final newData = await repository.search(keyword, page: page);
      // return [if (isLoadMore) ...state.value ?? [], ...newData];
      return newData;
    });
  }

  void load(String keyword, int page, isLoadMoreData) {
    // ローディング中にローディングしないようにする
    if (state ==
        const AsyncLoading<List<GitRepositoryData>>().copyWithPrevious(state)) {
      return;
    }

    // 取得済みのデータを保持しながら状態をローディング中にする
    state =
        const AsyncLoading<List<GitRepositoryData>>().copyWithPrevious(state);

    fetch(keyword, page, isLoadMoreData);
  }
}
