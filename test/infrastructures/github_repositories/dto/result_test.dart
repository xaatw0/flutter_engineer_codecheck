import 'dart:io';
import 'dart:convert';

import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/dto/result.dart';
import 'package:flutter_test/flutter_test.dart';

main() async {
  test('convert json to Result', () async {
    // 同じフォルダにあるFlutterで検索した結果のJsonファイルを読み込む
    const filePath =
        'test/infrastructures/github_repositories/dto/result_test.txt';
    final file = File(filePath);
    expect(file.existsSync(), true);

    final result = Result.fromJson(
        json.decode(file.readAsStringSync()) as Map<String, dynamic>);
    expect(result.totalCount, 455887);
    expect(result.items.length, 30);
    expect(result.items[0].name, 'flutter');
    expect(result.items[0].language, 'Dart');
    expect(result.items[0].owner.avatarUrl,
        'https://avatars.githubusercontent.com/u/14101776?v=4');
    expect(result.items[0].description,
        'Flutter makes it easy and fast to build beautiful apps for mobile and beyond');
    expect(result.items[0].createdAt, '2015-03-06T22:54:58Z');
    expect(result.items[0].updatedAt, '2022-12-06T23:38:33Z');

    expect(result.items[29].name, 'flutter_wanandroid');
  });
}
