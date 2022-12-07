import 'dart:convert';

import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:http/http.dart' as http;

import 'dto/result.dart';

/// Githubからデータを取得するためのレポジトリクラス。
/// 検索時に発生するエラー
/// ・ネットワークが繋がっていない、または遅い
/// ・WebAPIの形式が変更された
class GithubRepository implements GitRepository {
  static const String apiUrl =
      'https://api.github.com/search/repositories?q=<keyword>';

  @override
  Future<List<GitRepositoryData>> search(String keyword) async {
    // TODO 並び順、ページ数などへの対応
    final apiUri = Uri.parse(apiUrl.replaceFirst('<keyword>', keyword));
    http.Response response = await http.get(apiUri);
    return fromJson(response.body).toList();
  }

  Iterable<GitRepositoryData> fromJson(String jsonData) {
    final map = json.decode(jsonData);
    final result = Result.fromJson(map);
    return result.items.map((item) => item.toGitRepositoryData());
  }
}
