import 'dart:io';

import 'package:flutter_engineer_codecheck/domain/exceptions/git_repository_exception.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/usecase/search_repositoies_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索結果を表示するためのStateNotifier
/// (参考) https://www.zeroichi.biz/blog/1525/
class SearchResultNotifier
    extends StateNotifier<AsyncValue<List<SearchRepositoryDto>>> {
  SearchResultNotifier({
    required this.sortMethod,
    required this.keyword,
  }) : super(const AsyncLoading<List<SearchRepositoryDto>>());

  final SortMethod sortMethod;
  final String keyword;

  late final _searchRepository =
      SearchRepositoryUseCase(keyword, sortMethod: sortMethod);

  /// データの読込
  Future<void> fetch({
    required bool isLoadMoreData,
  }) async {
    if (isLoadMoreData) {
      state = const AsyncLoading<List<SearchRepositoryDto>>()
          .copyWithPrevious(state);
    }

    state = await AsyncValue.guard(() async {
      late final List<SearchRepositoryDto> newData;
      try {
        newData = await _searchRepository.execute();
      } on SocketException catch (exception, stacktrace) {
        // SocketExceptionの場合、ネットワーク関連のエラーのため、接続エラーする
        throw GitRepositoryException.notConnected(
          exception,
          stackTrace: stacktrace,
        );
      }

      // 同じIDがレポジトリがある場合、追加しない
      // (検索中に順位が入れ替わったケースを想定。その場合、抜けるレポジトリがあるのか)
      final existIds = state.value?.map((e) => e.repositoryId) ?? [];
      newData.removeWhere((e) => existIds.contains(e.repositoryId));
      return [if (isLoadMoreData) ...state.value ?? [], ...newData];
    });
  }

  /// ロード中かどうかを表す
  bool isLoading() =>
      state ==
      const AsyncLoading<List<SearchRepositoryDto>>().copyWithPrevious(state);
}
