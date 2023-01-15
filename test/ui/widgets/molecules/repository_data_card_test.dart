import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/domain/repository_data_types.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/sort_method_logic.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/repository_data_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_test_utility.dart';

Widget target() => MaterialApp(
      home: Column(
        children: [
          RepositoryDataCard(
            data: GitRepositoryData(
              repositoryId: RepositoryId(123),
              repositoryName: RepositoryName('repositoryName'),
              ownerIconUrl: OwnerIconUrl('OwnerIconUrl'),
              projectLanguage: ProjectLanguage('projectLanguage'),
              repositoryDescription:
                  const RepositoryDescription('repositoryDescription'),
              repositoryHtmlUrl: const RepositoryHtmlUrl('repositoryHtmlUrl'),
              countStar: CountStar(1),
              countWatcher: CountWatcher(2),
              countFork: CountFork(3),
              countIssue: CountIssue(4),
              createTime: RepositoryCreateTime(DateTime(2011, 2, 3)),
              updateTime: RepositoryUpdateTime(DateTime(2014, 5, 6)),
            ),
          ),
          RepositoryDataCard(
            data: GitRepositoryData(
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
            ),
          ),
          RepositoryDataCard(
            data: GitRepositoryData(
              repositoryId: RepositoryId(31792824),
              repositoryName: RepositoryName(
                'flutteraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', // ignore: lines_longer_than_80_chars
              ),
              ownerIconUrl:
                  OwnerIconUrl('OwnerIconUrl1aaaaaaaaaaaaaaaaaaaaaaaaaaa'),
              projectLanguage:
                  ProjectLanguage('Dartaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
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
            ),
          ),
          RepositoryDataCard(
            data: GitRepositoryData(
              repositoryId: RepositoryId(31792824),
              repositoryName: RepositoryName('あいうえお'),
              ownerIconUrl:
                  OwnerIconUrl('OwnerIconUrl1aaaaaaaaaaaaaaaaaaaaaaaaaaa'),
              projectLanguage:
                  ProjectLanguage('Dartaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
              repositoryDescription: const RepositoryDescription('かきくけこ'),
              repositoryHtmlUrl:
                  const RepositoryHtmlUrl('https://github.com/flutter/flutter'),
              countStar: CountStar(146985),
              countWatcher: CountWatcher(146985),
              countFork: CountFork(23912),
              countIssue: CountIssue(11313),
              createTime: RepositoryCreateTime(DateTime(2011, 2, 3)),
              updateTime: RepositoryUpdateTime(DateTime(2014, 5, 6)),
            ),
          ),
        ],
      ),
    );

void main() {
  final utility = GoldenTestUtility();
  final dirOS = utility.dirOS;

  setUpAll(() async {
    await utility.loadJapaneseFont();
  });

  testGoldens('RepositoryDataCard devices', (WidgetTester tester) async {
    for (final device in utility.devices) {
      await tester.pumpWidgetBuilder(
        ProviderScope(
          overrides: [
            sortMethodProvider.overrideWith(
              (ref) => SortMethodLogic(SortMethod.bestMatch),
            ),
          ],
          child: target(),
        ),
        surfaceSize: device.size,
      );
      await screenMatchesGolden(
          tester, '$dirOS/RepositoryDataCard_${device.name}');
    }
  });

  testGoldens('RepositoryDataCard bestmatch', (WidgetTester tester) async {
    const sortMethod = SortMethod.bestMatch;
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          sortMethodProvider.overrideWith(
            (ref) => SortMethodLogic(sortMethod),
          ),
        ],
        child: target(),
      ),
      surfaceSize: utility.devices.first.size,
    );
    await screenMatchesGolden(
        tester, '$dirOS/RepositoryDataCard_${sortMethod.name}');
  });

  testGoldens('RepositoryDataCard stars', (WidgetTester tester) async {
    const sortMethod = SortMethod.starAsc;
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          sortMethodProvider.overrideWith(
            (ref) => SortMethodLogic(sortMethod),
          ),
        ],
        child: target(),
      ),
      surfaceSize: utility.devices.first.size,
    );
    await screenMatchesGolden(
        tester, '$dirOS/RepositoryDataCard_${sortMethod.name}');
  });

  testGoldens('RepositoryDataCard forks', (WidgetTester tester) async {
    const sortMethod = SortMethod.forkAsc;
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          sortMethodProvider.overrideWith(
            (ref) => SortMethodLogic(sortMethod),
          ),
        ],
        child: target(),
      ),
      surfaceSize: utility.devices.first.size,
    );
    await screenMatchesGolden(
        tester, '$dirOS/RepositoryDataCard_${sortMethod.name}');
  });

  testGoldens('RepositoryDataCard updated', (WidgetTester tester) async {
    const sortMethod = SortMethod.recentlyUpdated;
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          sortMethodProvider.overrideWith(
            (ref) => SortMethodLogic(sortMethod),
          ),
        ],
        child: target(),
      ),
      surfaceSize: utility.devices.first.size,
    );
    await screenMatchesGolden(
        tester, '$dirOS/RepositoryDataCard_${sortMethod.name}');
  });
}
