import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_fork.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_issue.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_star.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/count_watcher.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/owner_icon_url.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/project_language.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_description.dart';
import 'package:flutter_engineer_codecheck/domain/value_objects/repository_name.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';

import '../../widgets/organisms/search_result_list_view.dart';

/// 検索結果を表示するためのページ
class SearchResultPage extends StatelessWidget {
  SearchResultPage({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  final String keyword;

  final List<GitRepositoryData> data = [
    GitRepositoryData(
      repositoryName: RepositoryName('aa'),
      ownerIconUrl:
          OwnerIconUrl('https://avatars.githubusercontent.com/u/14101776?v=4'),
      projectLanguage: ProjectLanguage('dart'),
      repositoryDescription: RepositoryDescription('aaa'),
      countStar: CountStar(1),
      countWatcher: CountWatcher(2),
      countFork: CountFork(3),
      countIssue: CountIssue(4),
    ),
    GitRepositoryData(
      repositoryName: RepositoryName('aa'),
      ownerIconUrl:
          OwnerIconUrl('https://avatars.githubusercontent.com/u/14101776?v=4'),
      projectLanguage: ProjectLanguage('dart'),
      repositoryDescription: RepositoryDescription('aaa'),
      countStar: CountStar(1),
      countWatcher: CountWatcher(2),
      countFork: CountFork(3),
      countIssue: CountIssue(4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DayNightTemplate(
      title: '[$keyword]の検索',
      children: [
        Expanded(
          child: SearchResultListView(data: data),
        ),
      ],
    );
  }
}
