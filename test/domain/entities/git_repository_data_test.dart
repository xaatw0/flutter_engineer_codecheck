import 'package:flutter_engineer_codecheck/domain/repository_data_types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('basic', () async {
    final target = GitRepositoryData(
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
      createTime: RepositoryCreateTime(DateTime(2022, 10)),
      updateTime: RepositoryUpdateTime(DateTime(2022, 10, 2)),
    );

    expect(target.repositoryId(), 123);
    expect(target.repositoryName(), 'repositoryName');
    expect(target.ownerIconUrl(), 'OwnerIconUrl');
    expect(target.projectLanguage(), 'projectLanguage');
    expect(target.repositoryDescription(), 'repositoryDescription');
    expect(target.repositoryHtmlUrl(), 'repositoryHtmlUrl');

    expect(target.countStar(), 1);
    expect(target.countWatcher(), 2);
    expect(target.countFork(), 3);
    expect(target.countIssue(), 4);

    expect(target.createTime(), DateTime(2022, 10));
    expect(target.updateTime(), DateTime(2022, 10, 2));
  });
}
