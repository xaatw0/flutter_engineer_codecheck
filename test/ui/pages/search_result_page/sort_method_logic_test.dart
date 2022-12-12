import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/sort_method_logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

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

main() async {
  final gitRepositoryData = GitRepositoryData(
    repositoryId: RepositoryId(123),
    repositoryName: RepositoryName('repositoryName'),
    ownerIconUrl: OwnerIconUrl('OwnerIconUrl'),
    projectLanguage: ProjectLanguage('projectLanguage'),
    repositoryDescription: const RepositoryDescription('repositoryDescription'),
    countStar: CountStar(1),
    countWatcher: CountWatcher(2),
    countFork: CountFork(3),
    countIssue: CountIssue(4),
    createTime: RepositoryCreateTime(DateTime(2011, 2, 3)),
    updateTime: RepositoryUpdateTime(DateTime(2014, 5, 6)),
  );

  test('star', () async {
    final sortMethods = [
      SortMethod.bestMatch,
      SortMethod.starAsc,
      SortMethod.starDesc
    ];
    for (final sortMethod in sortMethods) {
      final target = SortMethodLogic(sortMethod);
      expect(target.getIcon(), Icons.star);
      expect(target.getValue()(gitRepositoryData), '1');
    }
  });

  test('fork', () async {
    final sortMethods = [SortMethod.forkAsc, SortMethod.forkDesc];
    for (final sortMethod in sortMethods) {
      final target = SortMethodLogic(sortMethod);
      expect(target.getIcon(), Icons.fork_right);
      expect(target.getValue()(gitRepositoryData), '3');
    }
  });

  test('update', () async {
    final sortMethods = [
      SortMethod.recentlyUpdated,
      SortMethod.leastRecentlyUpdate,
    ];
    for (final sortMethod in sortMethods) {
      final target = SortMethodLogic(sortMethod);
      expect(target.getIcon(), Icons.update);
      expect(target.getValue()(gitRepositoryData), '2014/05/06');
    }
  });
}
