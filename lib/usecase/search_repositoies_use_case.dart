import 'dart:io';

import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:get_it/get_it.dart';

import '../domain/exceptions/git_repository_exception.dart';

/// Gitのレポジトリを検索するユースケース
class SearchRepositoryUseCase {
  SearchRepositoryUseCase(this.keyword,
      {this.sortMethod = SortMethod.bestMatch});

  final String keyword;
  final SortMethod sortMethod;

  // GitRepositoryのインスタンス
  final _gitRepository = GetIt.I.get<GitRepository>();

  late int _page = _gitRepository.getFirstPageIndex();

  Future<List<GitRepositoryData>> execute() async {
    late final List<GitRepositoryData> list;
    try {
      return _gitRepository.search(
        keyword,
        page: _page++,
        sortMethod: sortMethod,
      );
    } on SocketException catch (exception, stacktrace) {
      // SocketExceptionの場合、ネットワーク関連のエラーのため、接続エラーする
      throw GitRepositoryException.notConnected(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
