import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../lib/infrastructures/github_repositories/github_repository.dart';

main() async {
  test('fromJson', () async {
    final filePath =
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
    final page1 = await repository.search('flutter', page: 1);
    expect(page1.first.repositoryName(), 'flutter');

    // ページ2の最初は多分「Flutter」ではない
    final page2 = await repository.search('flutter', page: 2);
    expect(page2.first.repositoryName(), isNot('flutter'));
  });
}
