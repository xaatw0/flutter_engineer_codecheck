import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('basic', () async {
    final target = GitRepositoryData(
      repositoryName: RepositoryName('repositoryName'),
      ownerIconUrl: OwnerIconUrl('OwnerIconUrl'),
      projectLanguage: ProjectLanguage('projectLanguage'),
      countStar: CountStar(1),
      countWatcher: CountWatcher(2),
      countFork: CountFork(3),
      countIssue: CountIssue(4),
    );

    expect(target.repositoryName(), 'repositoryName');
    expect(target.ownerIconUrl(), 'OwnerIconUrl');
    expect(target.projectLanguage(), 'projectLanguage');

    expect(target.countStar(), 1);
    expect(target.countWatcher(), 2);
    expect(target.countFork(), 3);
    expect(target.countIssue(), 4);
  });
}
