import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_engineer_codecheck/main.dart' as app;
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/repository_data_card.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/search_result_list_view.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/theme_switcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/infrastructures/github_repositories/github_repository_test.mocks.dart';
import 'mock_result.dart' as result;

@GenerateMocks([http.Client])
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // DIの設定を変更して、GithubApi のデータをファイルから取得するようにする
  final mockClient = MockClient();
  GetIt.I.allowReassignment = true;

  // ファイルの確認とMockに設定
  const url1 = 'https://api.github.com/search/repositories?q=flutter&page=1';
  const url2 = 'https://api.github.com/search/repositories?q=flutter&page=2';

  when(mockClient.get(Uri.parse(url1))).thenAnswer(
    (_) async => http.Response(result.flutter1, 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }),
  );
  when(mockClient.get(Uri.parse(url2))).thenAnswer(
    (_) async => http.Response(result.flutter2, 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }),
  );

  testWidgets('start', (WidgetTester tester) async {
    app.main();
    GetIt.I.registerSingleton<http.Client>(mockClient);

    await binding.convertFlutterSurfaceToImage();

    // 起動画面
    await tester.pump();
    await binding.takeScreenshot('00_justLaunched');

    await tester.pumpAndSettle();
    await binding.takeScreenshot('01_logoShown');

    // テーマを切り替えて、ダークモードにする
    await tester.tap(find.byType(ThemeSwitcher));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('02_darkMode');

    // テーマを切り替えて、ライトモードにする
    await tester.tap(find.byType(ThemeSwitcher));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('03_lightMode');

    // キーボードを表示
    await tester.showKeyboard(find.byType(TextField));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('04_showKeyboard');

    // 検索キーワードを入力
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pumpAndSettle();
    await binding.takeScreenshot('05_enterText');

    // Enter を入力
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('06_enter');

    // Flutterの公式レポジトリのカードをタップ
    // (Flutterの公式レポジトリが検索のトップに来ていると想定)
    final flutter = find.text('flutter');
    await tester.tap(flutter);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('11_repositoryDetail');

    // テーマを切り替えて、ダークモードにする
    await tester.tap(find.byType(ThemeSwitcher));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('12_darkMode');

    // 前のページに戻る
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('13_pageResultDart');

    // テーマを切り替えて、ライトモードにする
    await tester.tap(find.byType(ThemeSwitcher));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('14_pageResultLight');

    // カードの数を確認する
    expect(find.byType(RepositoryDataCard), findsNWidgets(10));

    await tester.drag(
        find.byType(RepositoryDataCard).at(8), const Offset(0.0, -300));

    // これは動く
    // await tester.drag(find.text('flutterfire'), const Offset(0.0, -300));
    await tester.pumpAndSettle();

    await binding.takeScreenshot('15_scrolling1');

    expect(find.byType(RepositoryDataCard), findsNWidgets(10));

    await tester.drag(
        find.byType(RepositoryDataCard).at(8), const Offset(0.0, -300));
    await tester.pumpAndSettle();

    await binding.takeScreenshot('16_scrolling2');

    // 1ページ目のモックデータの最後のデータのname
    const endOfPage1Name = 'enfOfPage1';

    // 2ページ目のモックデータの最初のデータのname
    const startOfPage2Name = 'startOfPage2';

    // 1ページ目の最後のデータまでドラッグし続ける
    await tester.dragUntilVisible(
      find.text(endOfPage1Name),
      find.byType(SearchResultListView),
      const Offset(0, -50),
      maxIteration: 50,
    );

    await tester.pumpAndSettle();
    await binding.takeScreenshot('17_endOfPage1');

    // 1ページ目の最後のデータをドラッグすると、2ページ目のデータが読み込まれて表示される
    await tester.drag(find.text(endOfPage1Name), const Offset(0, -300));
    await Future<void>.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('18_startOfPage2');

    expect(find.text(startOfPage2Name), findsOneWidget);
  });
}
