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

  test('search', () async {});
}
