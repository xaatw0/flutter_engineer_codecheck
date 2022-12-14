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
  RepositoryDetailPage(this.repositoryData, {super.key})
      : columns = [
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
        ];

  /// パス
  static const path = '/repository';

  /// レポジトリの詳細情報
  final GitRepositoryData repositoryData;

  /// 表示する項目のWidgetのリスト
  final List<Widget> columns;

  late final Widget gridView = GridView.builder(
    shrinkWrap: true,
    itemCount: columns.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 60,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
    ),
    itemBuilder: (BuildContext context, int index) {
      return columns[index];
    },
  );

  @override
  Widget build(BuildContext context) {
    final description =
        repositoryData.repositoryDescription() ?? StringResources.kEmpty;
    return DayNightTemplate(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Column(
            children: [
              // レポジトリ名
              Center(
                child: Text(
                  repositoryData.repositoryName(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(height: isPortrait ? 20 : 10),
              // オーナー画像
              Row(
                mainAxisAlignment: isPortrait
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: isPortrait
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: OwnerImage.kHeroKey +
                          repositoryData.repositoryId().toString(),
                      child: OwnerClip(repositoryData.ownerIconUrl),
                    ),
                  ),
                  Visibility(
                    visible: !isPortrait,
                    child: Expanded(flex: 2, child: gridView),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Star, Watcher, Fork, Issue の一覧
              Visibility(
                visible: isPortrait,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: columns,
                ),
              ),
              SizedBox(height: isPortrait ? 20 : 0),
              // 詳細説明
              Visibility(
                visible: description.isNotEmpty,
                child: SingleChildScrollView(
                  child: RepositoryDetailDescription(description: description),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
