import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/main.dart' as app;
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/repository_data_card.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/theme_switcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/services.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('start', (WidgetTester tester) async {
    app.main();
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
  });
}
