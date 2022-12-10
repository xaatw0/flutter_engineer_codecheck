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

  /// パラメータのソート方法の置換用文字列
  static const kParamSort = '<sort>';

  /// パラメータのソートの昇順・降順の置換用文字列
  static const kParamOrder = '<order>';

  /// Github APIへソート条件をベストマッチ(デフォルト)でアクセスするためのURL
  static const String kApiUrlForBestMatch =
      'https://api.github.com/search/repositories?q=$kParamKeyword&page=$kParamPage';

  /// Github APIへソート条件をつけてアクセスするためのURL
  static const String kApiUrl =
      '$kApiUrlForBestMatch&sort=$kParamSort&order=$kParamOrder';

  /// 「検索結果の表示順」のソートの並び順とパラメータのキーワードとの対応表
  static const kMapOrder = <String, List<SortMethod>>{
    'asc': [
      SortMethod.starAsc,
      SortMethod.forkAsc,
      SortMethod.recentlyUpdated,
    ],
    'desc': [
      SortMethod.starDesc,
      SortMethod.forkDesc,
      SortMethod.leastRecentlyUpdate
    ],
  };

  /// 「検索結果の表示順」のソートの方法とパラメータのキーワードとの対応表
  static const kMapSort = <String, List<SortMethod>>{
    'star': [SortMethod.starAsc, SortMethod.starDesc],
    'fork': [SortMethod.forkAsc, SortMethod.forkDesc],
    'update': [
      SortMethod.recentlyUpdated,
      SortMethod.leastRecentlyUpdate,
    ],
  };

  @override
  Future<List<GitRepositoryData>> search(
    String keyword, {
    int page = 1,
    SortMethod sortMethod = SortMethod.bestMatch,
  }) async {
    // TODO 並び順、ページ数などへの対応
    final uri = kApiUrl
        .replaceFirst(kParamKeyword, keyword)
        .replaceFirst(kParamPage, page.toString());
    final apiUri = Uri.parse(uri);
    http.Response response = await http.get(apiUri);
    return fromJson(response.body).toList();
  }

  /// キーワード、ページ、ソート条件に基づいた検索用のURLを発行する
  String getSearchUrl(String keyword, int page, SortMethod sortMethod) {
    if (sortMethod == SortMethod.bestMatch) {
      return kApiUrlForBestMatch
          .replaceFirst(kParamKeyword, keyword)
          .replaceFirst(kParamPage, page.toString());
    } else {
      final paramSort = kMapSort.keys
          .where((key) => kMapSort[key]!.contains(sortMethod))
          .first;
      final paramOrder = kMapOrder.keys
          .where((key) => kMapOrder[key]!.contains(sortMethod))
          .first;

      return kApiUrl
          .replaceFirst(kParamKeyword, keyword)
          .replaceFirst(kParamPage, page.toString())
          .replaceFirst(kParamSort, paramSort)
          .replaceFirst(kParamOrder, paramOrder);
    }
  }

  Iterable<GitRepositoryData> fromJson(String jsonData) {
    final map = json.decode(jsonData);
    final result = Result.fromJson(map);
    return result.items.map((item) => item.toGitRepositoryData());
  }

  @override
  int getFirstPageIndex() {
    return 1;
  }
}
