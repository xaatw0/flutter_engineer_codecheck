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
  /// パラメータのキーワードの置換用文字列
  static const kParamKeyword = '<keyword>';

  /// パラメータのページ数の置換用文字列
  static const kParamPage = '<page>';

  /// Github APIへアクセスするためのURL
  static const String apiUrl =
      'https://api.github.com/search/repositories?q=$kParamKeyword&page=$kParamPage';

  @override
  Future<List<GitRepositoryData>> search(
    String keyword, {
    int page = 1,
  }) async {
    // TODO 並び順、ページ数などへの対応
    final uri = apiUrl
        .replaceFirst(kParamKeyword, keyword)
        .replaceFirst(kParamPage, page.toString());
    final apiUri = Uri.parse(uri);
    http.Response response = await http.get(apiUri);
    return fromJson(response.body).toList();
  }

  Iterable<GitRepositoryData> fromJson(String jsonData) {
    final map = json.decode(jsonData);
    final result = Result.fromJson(map);
    return result.items.map((item) => item.toGitRepositoryData());
  }
}
