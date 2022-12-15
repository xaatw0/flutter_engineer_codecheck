import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/domain/string_resources.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/owner_image.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';

import '../../responsive.dart';
import '../../widgets/molecules/owner_clip.dart';
import '../../widgets/molecules/repository_data_grid_view.dart';
import '../../widgets/molecules/repository_detail_column.dart';
import '../../widgets/molecules/repository_detail_description.dart';
import '../../widgets/organisms/github_launcher.dart';

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
  final List<RepositoryDetailColumn> columns;

  @override
  Widget build(BuildContext context) {
    final description =
        repositoryData.repositoryDescription() ?? StringResources.kEmpty;

    //表示項目の一行の数。
    // Widgetの場所で設定すると、向きで非表示になるので、データが取得できず例外になる。
    // そのため、ここで取得している。
    final columsCount = context.responsive<int>(2, sm: 4);

    return DayNightTemplate(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Column(
            children: [
              // レポジトリ名
              Center(
                child: AutoSizeText(
                  repositoryData.repositoryName(),
                  style: Theme.of(context).textTheme.displaySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  minFontSize:
                      // 最低でも項目の数字のフォントサイズ
                      Theme.of(context).textTheme.titleLarge!.fontSize!,
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
                    child: Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          RepositoryDataGridView(
                            columns: columns,
                            axisCount: columsCount,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: GithubLauncher(
                              repositoryData.repositoryHtmlUrl(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Star, Watcher, Fork, Issue の一覧
              Visibility(
                visible: isPortrait,
                child: RepositoryDataGridView(
                  columns: columns,
                  axisCount: columsCount,
                ),
              ),
              if (isPortrait)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GithubLauncher(
                    repositoryData.repositoryHtmlUrl(),
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
