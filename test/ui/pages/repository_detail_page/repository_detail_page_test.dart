import 'package:flutter/material.dart';

import 'package:flutter_engineer_codecheck/domain/repository_data_types.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_test_utility.dart';

void main() async {
  final utility = GoldenTestUtility();
  final dirOS = utility.dirOS;

  setUpAll(() async {
    await utility.loadJapaneseFont();
  });
  for (final theme in <ThemeMode>[ThemeMode.light, ThemeMode.dark]) {
    testGoldens('RepositoryDetailPage short data ${theme.name}',
        (WidgetTester tester) async {
      final repositoryData = GitRepositoryData(
        repositoryId: RepositoryId(123),
        repositoryName: RepositoryName('repositoryName'),
        ownerIconUrl: OwnerIconUrl('OwnerIconUrl'),
        projectLanguage: ProjectLanguage('projectLanguage'),
        repositoryDescription:
            const RepositoryDescription('repositoryDescription'),
        repositoryHtmlUrl: const RepositoryHtmlUrl('repositoryDescription'),
        countStar: CountStar(1),
        countWatcher: CountWatcher(2),
        countFork: CountFork(3),
        countIssue: CountIssue(4),
        createTime: RepositoryCreateTime(DateTime(2011, 2, 3)),
        updateTime: RepositoryUpdateTime(DateTime(2014, 5, 6)),
      );

      final target = MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: theme == ThemeMode.light
            ? app_theme.lightTheme
            : app_theme.darkTheme,
        home: ProviderScope(
          overrides: [
            app_theme.themeMode.overrideWith(
              (ref) => theme,
            ),
          ],
          child: RepositoryDetailPage(repositoryData),
        ),
      );

      for (final device in utility.devices) {
        await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
        await tester.pumpAndSettle();
        await screenMatchesGolden(
          tester,
          '$dirOS/RepositoryDetailPage_short_${theme.name}_${device.name}',
        );
      }
    });
  }
  testGoldens('RepositoryDetailPage normal data', (WidgetTester tester) async {
    final repositoryData = GitRepositoryData(
      repositoryId: RepositoryId(31792824),
      repositoryName: RepositoryName('flutter'),
      ownerIconUrl: OwnerIconUrl('OwnerIconUrl1'),
      projectLanguage: ProjectLanguage('Dart'),
      repositoryDescription: const RepositoryDescription(
        'Flutter makes it easy and fast to build beautiful apps for mobile and beyond', // ignore: lines_longer_than_80_chars
      ),
      repositoryHtmlUrl:
          const RepositoryHtmlUrl('https://github.com/flutter/flutter'),
      countStar: CountStar(146985),
      countWatcher: CountWatcher(146985),
      countFork: CountFork(23912),
      countIssue: CountIssue(11313),
      createTime: RepositoryCreateTime(DateTime(2011, 2, 3)),
      updateTime: RepositoryUpdateTime(DateTime(2014, 5, 6)),
    );

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
        child: RepositoryDetailPage(repositoryData),
      ),
    );

    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
      await tester.pumpAndSettle();
      await screenMatchesGolden(
        tester,
        '$dirOS/RepositoryDetailPage_normal_light_${device.name}',
      );
    }
  });

  testGoldens('RepositoryDetailPage long data', (WidgetTester tester) async {
    final repositoryData = GitRepositoryData(
      repositoryId: RepositoryId(31792824),
      repositoryName: RepositoryName(
        'flutteraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', // ignore: lines_longer_than_80_chars
      ),
      ownerIconUrl: OwnerIconUrl('OwnerIconUrl1aaaaaaaaaaaaaaaaaaaaaaaaaaa'),
      projectLanguage: ProjectLanguage('Dartaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
      repositoryDescription: const RepositoryDescription(
        'Flutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyond', // ignore: lines_longer_than_80_chars
      ),
      repositoryHtmlUrl:
          const RepositoryHtmlUrl('https://github.com/flutter/flutter'),
      countStar: CountStar(146985),
      countWatcher: CountWatcher(146985),
      countFork: CountFork(23912),
      countIssue: CountIssue(11313),
      createTime: RepositoryCreateTime(DateTime(2011, 2, 3)),
      updateTime: RepositoryUpdateTime(DateTime(2014, 5, 6)),
    );

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
        child: RepositoryDetailPage(repositoryData),
      ),
    );

    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(target, surfaceSize: device.size);
      await tester.pumpAndSettle();
      await screenMatchesGolden(
        tester,
        '$dirOS/RepositoryDetailPage_long_light_${device.name}',
      );
    }
  });
}
