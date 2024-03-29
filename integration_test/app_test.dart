import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';

import 'package:flutter_engineer_codecheck/main.dart' as app;
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/github_icon.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/repository_data_card.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/search_result_list_view.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/sun_and_moon_coin.dart';
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

  /// Android端末であればスクリーンショットを撮る
  /// iPhone端末ではスクリーンショットが撮れない(例外が発生する)
  Future<void> takeScreenshot(String title) async {
    if (Platform.isAndroid) {
      await binding.takeScreenshot(title);
    }
  }

  Future<void> initialize() async {
    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
    }
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // DIの設定を変更して、GithubApi のデータをファイルから取得するようにする
  final mockClient = MockClient();
  GetIt.I.allowReassignment = true;

  // ファイルの確認とMockに設定
  const url1 = 'https://api.github.com/search/repositories?q=flutter&page=1';
  const url2 = 'https://api.github.com/search/repositories?q=flutter&page=2';
  const url3 =
      'https://api.github.com/search/repositories?q=flutter&page=1&sort=updated&order=asc';
  const urlNoResult =
      'https://api.github.com/search/repositories?q=noResult&page=1';

  // 1ページ目のモックデータの最後のデータのname
  const endOfPage1Name = 'enfOfPage1';

  // 2ページ目のモックデータの最初のデータのname
  const startOfPage2Name = 'startOfPage2';

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

  when(mockClient.get(Uri.parse(url1)))
      .thenAnswer((_) async => getDummyResponse(result.flutter1));
  when(mockClient.get(Uri.parse(url2)))
      .thenAnswer((_) async => getDummyResponse(result.flutter2));
  when(mockClient.get(Uri.parse(url3)))
      .thenAnswer((_) async => getDummyResponse(result.flutter1));
  when(mockClient.get(Uri.parse(urlNoResult)))
      .thenAnswer((_) async => getDummyResponse(result.noResult));

  final backIcon = Platform.isAndroid
      ? Icons.arrow_back
      : Platform.isIOS
          ? Icons.arrow_back_ios
          : throw UnsupportedError('OS用のバックアイコンを設定してください');

  testWidgets('portrait', (WidgetTester tester) async {
    GetIt.I.registerSingleton<http.Client>(mockClient);
    GetIt.I.registerSingleton<List<DeviceOrientation>>(
      [DeviceOrientation.portraitUp],
    );
    GetIt.I.registerFactory<Locale>(() => const Locale('en'));
    app.main();

    await initialize();

    const orientation = 'portrait';

    // 起動画面
    await tester.pump();
    await takeScreenshot('${orientation}_00_justLaunched');

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_01_logoShown');

    // テーマを切り替えて、ダークモードにする
    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_02_darkMode');

    // テーマを切り替えて、ライトモードにする
    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_03_lightMode');

    // キーボードを表示
    await tester.showKeyboard(find.byType(TextField));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_04_showKeyboard');

    // 結果無し用の検索キーワードを入力
    await tester.enterText(find.byType(TextField), 'noResult');
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_05_enterNoResult');

    // Enter を入力
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_06_resultPageWithNoResult');

    // 検索結果無しを表示
    await tester.tap(find.byIcon(backIcon));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_07_searchPage');

    // 検索キーワードを入力
    final textFinder = find.byType(TextField);
    expect(textFinder, findsOneWidget);
    await tester.tap(textFinder);
    await tester.enterText(textFinder, 'flutter');
    expect(find.text('noResult'), findsNothing);
    expect(find.text('flutter'), findsOneWidget);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_08_enterFlutter');

    // Enter を入力して、Flutterの検索結果を表示
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_09_resultPageForFlutter');

    // Flutterの公式レポジトリのカードをタップ
    // (Flutterの公式レポジトリが検索のトップに来ていると想定→MOCKのため、必ずある)
    final flutter = find.text('flutter');
    await tester.tap(flutter);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_11_repositoryDetail');

    // テーマを切り替えて、ダークモードにする

    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_12_darkMode');

    // 前のページに戻る
    await tester.tap(find.byIcon(backIcon));
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await takeScreenshot('${orientation}_13_pageResultDart');
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // テーマを切り替えて、ライトモードにする
    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_14_pageResultLight');

    // カードの数を確認する
    expect(find.byType(RepositoryDataCard), findsWidgets);

    await tester.drag(
      find.byType(RepositoryDataCard).at(3),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_15_scrolling1');

    await tester.drag(
      find.byType(RepositoryDataCard).at(3),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    await takeScreenshot(
      '${orientation}_16_scrolling2',
    );

    // 1ページ目の最後のデータまでドラッグし続ける
    await tester.dragUntilVisible(
      find.text(endOfPage1Name),
      find.byType(SearchResultListView),
      const Offset(0, -50),
    );

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_17_endOfPage1');

    // 1ページ目の最後のデータをドラッグすると、2ページ目のデータが読み込まれて表示される
    await tester.drag(find.text(endOfPage1Name), const Offset(0, -300));
    await Future<void>.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_18_startOfPage2');

    expect(find.text(startOfPage2Name), findsOneWidget);

    // 検索ページに戻る
    await tester.tap(find.byIcon(backIcon));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_21_searchPageWithKeyword');
  });

  testWidgets('landscape', (WidgetTester tester) async {
    await initialize();
    GetIt.I.registerSingleton<List<DeviceOrientation>>(
      [DeviceOrientation.landscapeLeft],
    );
    const orientation = 'landscape';

    // アプリを起動
    app.main();

    // 起動画面
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_00_justLaunched');

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_01_logoShown');

    // テーマを切り替えて、ダークモードにする
    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_02_darkMode');

    // テーマを切り替えて、ライトモードにする
    await tester.tap(find.byType(SunAndMoonCoin));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_03_lightMode');

    expect(find.byType(GithubIcon), findsOneWidget);

    // キーボードを表示
    await tester.showKeyboard(find.byType(TextField));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_04_showKeyboard');

    // 結果無し用の検索キーワードを入力
    await tester.enterText(find.byType(TextField), 'noResult');
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_05_enterNoResult');

    // Enter を入力
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_06_resultPageWithNoResult');

    // 検索結果無しを表示
    await tester.tap(find.byIcon(backIcon));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_07_searchPage');

    // 検索キーワードを入力
    final textFinder = find.byType(TextField);
    expect(textFinder, findsOneWidget);
    await tester.tap(textFinder);
    await tester.enterText(textFinder, 'flutter');
    expect(find.text('noResult'), findsNothing);
    expect(find.text('flutter'), findsOneWidget);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_08_enterFlutter');

    // Enter を入力して、Flutterの検索結果を表示
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_09_resultPageForFlutter');

    // Flutterの公式レポジトリのカードをタップ
    // (Flutterの公式レポジトリが検索のトップに来ていると想定→MOCKのため、必ずある)
    final flutter = find.text('flutter');
    await tester.tap(flutter);
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_11_repositoryDetail');

    // テーマを切り替えて、ダークモードにする
    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_12_darkMode');

    // 前のページに戻る
    await tester.tap(find.byIcon(backIcon));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_13_pageResultDart');

    // テーマを切り替えて、ライトモードにする
    await tester.tap(find.byType(SunAndMoonCoin));

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_14_pageResultLight');

    // 1ページ目の最後のデータまでドラッグし続ける
    await tester.dragUntilVisible(
      find.text(endOfPage1Name),
      find.byType(SearchResultListView),
      const Offset(0, -50),
      maxIteration: 100,
    );

    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_17_endOfPage1');

    // 1ページ目の最後のデータをドラッグすると、2ページ目のデータが読み込まれて表示される
    await tester.drag(find.text(endOfPage1Name), const Offset(0, -300));
    await Future<void>.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_18_startOfPage2');

    expect(find.text(startOfPage2Name), findsOneWidget);

    // 検索ページに戻る
    await tester.tap(find.byIcon(backIcon));
    await tester.pumpAndSettle();
    await takeScreenshot('${orientation}_21_searchPageWithKeyword');
  });

  testWidgets('selectDialog', (WidgetTester tester) async {
    GetIt.I.registerSingleton<http.Client>(mockClient);
    GetIt.I.registerSingleton<List<DeviceOrientation>>(
      [DeviceOrientation.portraitUp],
    );
    app.main();

    await initialize();

    const testName = 'selectDialog';

    // 起動画面
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_00_justLaunched');

    // フィルターを押す
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_01_showDialogWithDefault');

    // ボタンの確認
    expect(find.text(SortMethod.leastRecentlyUpdate.title), findsOneWidget);
    expect(find.text('Least recently updated'), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    // Least updated を押す
    await tester.tap(find.text(SortMethod.leastRecentlyUpdate.title));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_02_tapLeastRecentlyUpdate');

    // キャンセル
/*
    final finderRichText =
        find.byWidgetPredicate((widget) => widget is RichText);

    for (final a in finderRichText.evaluate()) {
      print(a.widget.toStringShort());
    }
    final finderText = find.byWidgetPredicate((widget) => widget is Text);

    for (final a in finderText.evaluate()) {
      print(a.widget.toStringShort());
    }
    print(finderRichText);

 */
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_03_canceled');

    // フィルターを押す
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_04_showDialogWithoutChange');

    // Least updated を押す
    await tester.tap(find.text(SortMethod.leastRecentlyUpdate.title));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_05_tapLeastRecentlyUpdateAgain');

    // OK
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_06_ok');

    // フィルターを押す
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_07_showDialogWithChange');

    //検索キーワードを入力して検索
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pumpAndSettle();
    await takeScreenshot('${testName}_11_enterKeyword');

    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    await takeScreenshot('${testName}_12_resultWithUpdate');
  });
}
