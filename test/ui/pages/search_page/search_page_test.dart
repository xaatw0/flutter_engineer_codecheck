import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page_vm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_utility.dart';

@GenerateNiceMocks([MockSpec<SearchPageVm>()])
import 'search_page_test.mocks.dart';

void main() async {
  final utility = GoldenTestUtility();
  final mockVm = MockSearchPageVm();
  GetIt.I.registerSingleton<SearchPageVm>(mockVm);

  setUpAll(() async {
    await utility.loadJapaneseFont();
  });

  test('mockito test', () async {
    expect(mockVm.isDarkMode, false);
    when(mockVm.isDarkMode).thenReturn(true);
    expect(mockVm.isDarkMode, true);
  });

  testGoldens('SearchPage devices lightMode', (WidgetTester tester) async {
    when(mockVm.isDarkMode).thenReturn(false);

    final target = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: app_theme.lightTheme,
      home: ProviderScope(
        overrides: [
          app_theme.themeMode.overrideWith(
            (ref) => ThemeMode.light,
          ),
        ],
        child: const SearchPage(),
      ),
    );

    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'SearchPage_light_${device.name}');
    }
  });

  testGoldens('SearchPage devices darkMode', (WidgetTester tester) async {
    when(mockVm.isDarkMode).thenReturn(true);

    final target = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: app_theme.dartTheme,
      home: ProviderScope(
        overrides: [
          app_theme.themeMode.overrideWith(
            (ref) => ThemeMode.dark,
          ),
        ],
        child: const SearchPage(),
      ),
    );

    final device = utility.devices.first;
    await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'SearchPage_dark_${device.name}');
  });

  /**
   キーボードを表示させた状態を見たいが、キーボードが表示されない
  testGoldens('SearchPage devices showKeyboard', (WidgetTester tester) async {
    when(mockVm.isDarkMode).thenReturn(false);

    final target = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      home: ProviderScope(
        overrides: [
          AppTheme.themeMode.overrideWith(
            (ref) => ThemeMode.light,
          ),
        ],
        child: SearchPage(),
      ),
    );

    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
      await tester.showKeyboard(find.byType(TextField));
      await tester.enterText(find.byType(TextField), "newText");
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'SearchPage_keyboard_${device.name}');
    }
  });
*/
  testGoldens('SearchPage devices language', (WidgetTester tester) async {
    when(mockVm.isDarkMode).thenReturn(false);

    const locales = [
      Locale('en'),
      Locale('ja'),
      Locale('fr'),
      Locale('zh', 'TW'),
    ];

    for (final locale in locales) {
      final target = MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.lightTheme,
        locale: locale,
        home: ProviderScope(
          overrides: [
            app_theme.themeMode.overrideWith(
              (ref) => ThemeMode.light,
            ),
          ],
          child: const SearchPage(),
        ),
      );

      final device = utility.devices.first;
      await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
      await tester.pumpAndSettle();
      final lang = locale.languageCode +
          (locale.countryCode == null ? '' : '_${locale.languageCode}');
      await screenMatchesGolden(tester, 'SearchPage_lang_$lang');
    }
  });

  /// ソートのボタンをタップするテストを実施する
  /// ソート方法の選択ダイアログが表示されることを期待したが、Mock化しているので表示されない。
  /// とりあえず、ViewModelの対応するタップイベントが呼ばれていることを確認した。
  testGoldens('SearchPage tap sort Icon', (WidgetTester tester) async {
    when(mockVm.isDarkMode).thenReturn(false);

    final target = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: app_theme.lightTheme,
      home: ProviderScope(
        overrides: [
          app_theme.themeMode.overrideWith(
            (ref) => ThemeMode.light,
          ),
        ],
        child: const SearchPage(),
      ),
    );

    final device = utility.devices.first;
    await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
    verifyNever(mockVm.onSelectSortMethod(any));
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    verify(mockVm.onSelectSortMethod(any)).called(1);
    await screenMatchesGolden(tester, 'SearchPage_tap_sort_icon');
  });

  testGoldens('SearchPage hide theme-switcher and github icon',
      (WidgetTester tester) async {
    when(mockVm.isDarkMode).thenReturn(false);

    // キーボードが表示されているときにTrueになる
    when(mockVm.isKeywordAvailable).thenReturn(true);

    final target = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: app_theme.lightTheme,
      home: ProviderScope(
        overrides: [
          app_theme.themeMode.overrideWith(
            (ref) => ThemeMode.light,
          ),
        ],
        child: const SearchPage(),
      ),
    );

    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
      await tester.pumpAndSettle();
      await screenMatchesGolden(
          tester,
          'SearchPage_keyboard'
          '_${device.name}');
    }
  });
}
