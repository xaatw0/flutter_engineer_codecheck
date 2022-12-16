import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/github_repository.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/sort_method_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_utility.dart';
import 'mock_result.dart' as result;
import 'search_result_page_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  final utility = GoldenTestUtility();

  // DIの設定を変更して、GithubApi のデータをファイルから取得するようにする
  final mockClient = MockClient();

  // ダミーデータの設定
  http.Response getDummyResponse(String result) {
    return http.Response(
      result,
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );
  }

  when(mockClient.get(any))
      .thenAnswer((_) async => getDummyResponse(result.flutter1));

  // DIの登録
  GetIt.I.registerSingleton<http.Client>(mockClient);
  GetIt.I.registerSingleton<GitRepository>(GithubRepository());

  setUpAll(() async {
    await utility.loadJapaneseFont();
  });

  MaterialApp getTarget(ThemeMode theme, SortMethod sortMethod) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme:
          theme == ThemeMode.light ? app_theme.lightTheme : app_theme.darkTheme,
      home: ProviderScope(
        overrides: [
          app_theme.themeMode.overrideWith(
            (ref) => theme,
          ),
          sortMethodProvider.overrideWith(
            (ref) => SortMethodLogic(sortMethod),
          ),
        ],
        child: SearchResultPage(
          keyword: 'flutter',
          sortMethod: sortMethod,
        ),
      ),
    );
  }

  for (final theme in <ThemeMode>[ThemeMode.light, ThemeMode.dark]) {
    testGoldens('SearchResultPage device ${theme.name}',
        (WidgetTester tester) async {
      for (final device in utility.devices) {
        await tester.pumpWidgetBuilder(
          getTarget(theme, SortMethod.bestMatch),
          surfaceSize: device.size,
        );
        await tester.pumpAndSettle();
        await screenMatchesGolden(
          tester,
          'SearchResultPage_display_${theme.name}_${device.name}',
        );
      }
    });
  }

  // overrideWithはtestGoldens 内で1回だけのようなので、SortMethod.valuesを外に出して対応する
  for (final sortMethod in SortMethod.values) {
    testGoldens('SearchResultPage sortMethod: ${sortMethod.title}',
        (WidgetTester tester) async {
      await tester.pumpWidgetBuilder(
        getTarget(ThemeMode.light, sortMethod),
        surfaceSize: utility.devices.first.size,
      );
      await tester.pumpAndSettle();
      await screenMatchesGolden(
        tester,
        'SearchResultPage_sortMethod_${sortMethod.title}',
      );
    });
  }

  testGoldens('SearchResultPage noResult', (WidgetTester tester) async {
    when(mockClient.get(any))
        .thenAnswer((_) async => getDummyResponse(result.noResult));

    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(
        getTarget(ThemeMode.light, SortMethod.bestMatch),
        surfaceSize: device.size,
      );
      print('aaa');
      //await tester.pumpAndSettle();
      await screenMatchesGolden(
        tester,
        'SearchResultPage_noResult_${device.name}',
      );
      print('end1');
    }
  });
}
