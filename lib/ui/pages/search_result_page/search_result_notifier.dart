import 'dart:io';

import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/exceptions/git_repository_exception.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索結果を表示するためのStateNotifier
/// (参考) https://www.zeroichi.biz/blog/1525/
class SearchResultNotifier
    extends StateNotifier<AsyncValue<List<GitRepositoryData>>> {
  SearchResultNotifier(this.repository)
      : super(const AsyncLoading<List<GitRepositoryData>>());

  final GitRepository repository;

  /// データの読込
  Future<void> fetch(
    String keyword,
    int page,
    SortMethod sortMethod, {
    required bool isLoadMoreData,
  }) async {
    if (isLoadMoreData) {
      state =
          const AsyncLoading<List<GitRepositoryData>>().copyWithPrevious(state);
    }

    state = await AsyncValue.guard(() async {
      late final List<GitRepositoryData> newData;
      try {
        newData = await repository.search(
          keyword,
          page: page,
          sortMethod: sortMethod,
        );
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
      const AsyncLoading<List<GitRepositoryData>>().copyWithPrevious(state);
}
