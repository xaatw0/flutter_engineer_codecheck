import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/string_resources.dart';

import '../../../domain/entities/git_repository_data.dart';
import '../atoms/owner_image.dart';

/// レポジトリの情報を表示するカード
class RepositoryDataCard extends StatelessWidget {
  const RepositoryDataCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final GitRepositoryData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // 画像
        leading: Hero(
            tag: OwnerImage.kHeroKey + data.repositoryId().toString(),
            child: OwnerImage(url: data.ownerIconUrl())),
        // レポジトリ名
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AutoSizeText(
            data.repositoryName(),
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // レポジトリの概要
        subtitle: AutoSizeText(
          data.repositoryDescription() ?? StringResources.kEmpty,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        // 右隅 画像と数字
        trailing: Column(
          children: [
            Icon(Icons.star),
            Text(data.countStar().toString()),
          ],
        ),
      ),
    );
  }
}
