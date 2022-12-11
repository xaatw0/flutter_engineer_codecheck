import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_created_time.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_description.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_id.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_updated_time.dart';
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
                  RepositoryDescription('repositoryDescription'),
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
              repositoryDescription: RepositoryDescription(
                  'Flutter makes it easy and fast to build beautiful apps for mobile and beyond'),
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
                  'flutteraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
              ownerIconUrl:
                  OwnerIconUrl('OwnerIconUrl1aaaaaaaaaaaaaaaaaaaaaaaaaaa'),
              projectLanguage:
                  ProjectLanguage('Dartaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
              repositoryDescription: RepositoryDescription(
                  'Flutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyondFlutter makes it easy and fast to build beautiful apps for mobile and beyond'),
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
              repositoryDescription: RepositoryDescription('かきくけこ'),
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
  setUpAll(() async {
    await utility.loadJapaneseFont();
  });

  testGoldens('RepositoryDataCard', (WidgetTester tester) async {
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
          surfaceSize: device.size);
      await screenMatchesGolden(tester, 'RepositoryDataCard_${device.name}');
    }
  });
}
