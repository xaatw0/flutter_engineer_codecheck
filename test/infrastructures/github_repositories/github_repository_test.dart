import 'dart:io';

import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/github_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'github_repository_test.mocks.dart';
import 'mock_result.dart' as result;

@GenerateMocks([http.Client])
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

  test('mock', () async {
    final client = MockClient();

    final uri = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
    when(client.get(uri)).thenAnswer((_) async => http.Response('ok', 200));

    final result = await client.get(uri);
    expect(result.body, 'ok');
    expect(result.statusCode, 200);
  });

  test('mockdata from file', () async {
    const filePath =
        'test/infrastructures/github_repositories/dto/result_test.txt';
    final file = File(filePath);
    expect(file.existsSync(), true);

    final uri = Uri.parse(
      'https://api.github.com/search/repositories?q=flutter&page=1',
    );

    final client = MockClient();
    when(client.get(uri)).thenAnswer(
      (_) async => http.Response(file.readAsStringSync(), 200),
    );

    final repository = GithubRepository();
    final result = await repository.search('flutter');
    expect(result.length, 30);
    expect(result[0].repositoryName(), 'flutter');
  });

  test('file and member', () async {
    const filePath =
        'test/infrastructures/github_repositories/dto/result_test.txt';
    final file = File(filePath);
    expect(file.existsSync(), true);

    final fileData = file.readAsStringSync();
    expect(fileData.replaceAll('\r', ''), result.flutter1);
  });
}
