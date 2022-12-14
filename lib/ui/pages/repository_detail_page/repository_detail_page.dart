import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/string_resources.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/owner_image.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';

import '../../widgets/molecules/owner_clip.dart';
import '../../widgets/molecules/repository_detail_column.dart';
import '../../widgets/molecules/repository_detail_description.dart';

/// レポジトリの詳細を表示するページ
class RepositoryDetailPage extends StatelessWidget {
  const RepositoryDetailPage(this.repositoryData, {super.key});

  static const path = '/repository';

  final GitRepositoryData repositoryData;

  @override
  Widget build(BuildContext context) {
    final description =
        repositoryData.repositoryDescription() ?? StringResources.kEmpty;
    return DayNightTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // オーナー画像
            Hero(
              tag: OwnerImage.kHeroKey +
                  repositoryData.repositoryId().toString(),
              child: OwnerClip(repositoryData.ownerIconUrl),
            ),
            const SizedBox(height: 20),
            // レポジトリ名
            Center(
              child: Text(
                repositoryData.repositoryName(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: 20),
            // Star, Wather, Fork, Issue の一覧
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RepositoryDetailColumn(
                  StringResources.kStar,
                  repositoryData.countStar(),
                ),
                RepositoryDetailColumn(
                  StringResources.kWatchers,
                  repositoryData.countWatcher(),
                ),
                RepositoryDetailColumn(
                  StringResources.kForks,
                  repositoryData.countFork(),
                ),
                RepositoryDetailColumn(
                  StringResources.kIssues,
                  repositoryData.countIssue(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // 詳細説明
            Visibility(
              visible: description.isNotEmpty,
              child: RepositoryDetailDescription(description: description),
            ),
          ],
        ),
      ),
    );
  }
}
