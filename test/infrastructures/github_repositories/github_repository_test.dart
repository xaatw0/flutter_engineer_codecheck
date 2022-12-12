import 'dart:io';

import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/github_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('fromJson', () async {
    const filePath =
        'test/infrastructures/github_repositories/dto/result_test.txt';
    final file = File(filePath);
    expect(file.existsSync(), true);

    final repository = GithubRepository();
    final result = repository.fromJson(file.readAsStringSync());

    expect(result.length, 30);
    expect(result.first.repositoryName(), 'flutter');
  });

  test('page', () async {
    final repository = GithubRepository();
    final result = await repository.search('flutter');

    expect(result.length, 30);
    expect(result.first.repositoryName(), 'flutter');

    // ページ1の最初は公式だし、多分「flutter」。
    final page1 = await repository.search('flutter');
    expect(page1.first.repositoryName(), 'flutter');

    // ページ2の最初は多分「Flutter」ではない
    final page2 = await repository.search('flutter', page: 2);
    expect(page2.first.repositoryName(), isNot('flutter'));
  });

  test('getSearchUrl', () async {
    final repository = GithubRepository();

    // キーワードとページ
    expect(
      repository.getSearchUrl('keyword1', 1, SortMethod.bestMatch),
      'https://api.github.com/search/repositories?q=keyword1&page=1',
    );
    expect(
      repository.getSearchUrl('keyword2', 2, SortMethod.bestMatch),
      'https://api.github.com/search/repositories?q=keyword2&page=2',
    );

    // スター
    expect(
      repository.getSearchUrl('keyword1', 1, SortMethod.starAsc),
      'https://api.github.com/search/repositories?q=keyword1&page=1&sort=stars&order=asc',
    );
    expect(
      repository.getSearchUrl('keyword2', 2, SortMethod.starDesc),
      'https://api.github.com/search/repositories?q=keyword2&page=2&sort=stars&order=desc',
    );

    // フォーク
    expect(
      repository.getSearchUrl('keyword1', 1, SortMethod.forkAsc),
      'https://api.github.com/search/repositories?q=keyword1&page=1&sort=forks&order=asc',
    );
    expect(
      repository.getSearchUrl('keyword2', 2, SortMethod.forkDesc),
      'https://api.github.com/search/repositories?q=keyword2&page=2&sort=forks&order=desc',
    );

    // 更新日時
    expect(
      repository.getSearchUrl('keyword1', 1, SortMethod.recentlyUpdated),
      'https://api.github.com/search/repositories?q=keyword1&page=1&sort=updated&order=desc',
    );
    expect(
      repository.getSearchUrl('keyword2', 2, SortMethod.leastRecentlyUpdate),
      'https://api.github.com/search/repositories?q=keyword2&page=2&sort=updated&order=asc',
    );
  });
}
