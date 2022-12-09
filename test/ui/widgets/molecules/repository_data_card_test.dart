import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_description.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_id.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/repository_data_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

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
            ),
          ),
        ],
      ),
    );

void main() {
  testGoldens('RepositoryDataCard', (WidgetTester tester) async {
    await loadAppFonts();
    const size6 = Size(375, 667);

    await tester.pumpWidgetBuilder(target(), surfaceSize: size6);
    await screenMatchesGolden(tester, 'OwnerImage');
  });
}
