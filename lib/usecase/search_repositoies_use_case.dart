import 'dart:io';

import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:get_it/get_it.dart';

import '../domain/exceptions/git_repository_exception.dart';
import '../domain/string_resources.dart';

/// Gitのレポジトリを検索するユースケース
class SearchRepositoryUseCase {
  SearchRepositoryUseCase(
    this.keyword, {
    this.sortMethod = SortMethod.bestMatch,
  });

  final String keyword;
  final SortMethod sortMethod;

  // GitRepositoryのインスタンス
  final _gitRepository = GetIt.I.get<GitRepository>();

  late int _page = _gitRepository.getFirstPageIndex();

  Future<List<SearchRepositoryDto>> execute() async {
    try {
      final data = await _gitRepository.search(
        keyword,
        page: _page++,
        sortMethod: sortMethod,
      );
      return data.map(SearchRepositoryDto.new).toList();
    } on SocketException catch (exception, stacktrace) {
      // SocketExceptionの場合、ネットワーク関連のエラーのため、接続エラーする
      throw GitRepositoryException.notConnected(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}

class SearchRepositoryDto {
  SearchRepositoryDto(GitRepositoryData data)
      : countStar = data.countStar(),
        countWather = data.countWatcher(),
        countFork = data.countFork(),
        countIssue = data.countIssue(),
        repositoryName = data.repositoryName(),
        repositoryDescription =
            data.repositoryDescription() ?? StringResources.kEmpty,
        repositoryId = data.repositoryId(),
        repositoryHtmlUrl = data.repositoryHtmlUrl(),
        ownerIconUrl = data.ownerIconUrl(),
        updateTime = data.updateTime();

  final int countStar;
  final int countWather;
  final int countFork;
  final int countIssue;
  final String repositoryDescription;
  final String repositoryName;
  final int repositoryId;
  final String repositoryHtmlUrl;
  final String ownerIconUrl;
  final DateTime updateTime;
}
