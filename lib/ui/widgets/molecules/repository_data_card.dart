import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/string_resources.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/git_repository_data.dart';
import '../atoms/owner_image.dart';

/// レポジトリの情報を表示するカード
class RepositoryDataCard extends StatelessWidget {
  const RepositoryDataCard({
    super.key,
    required this.data,
  });

  final GitRepositoryData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${data.repositoryName}  ${data.repositoryDescription}',
      child: Card(
        child: ListTile(
          // 画像
          leading: Hero(
            tag: OwnerImage.kHeroKey + data.repositoryId().toString(),
            child: ExcludeSemantics(
              child: OwnerImage(url: data.ownerIconUrl()),
            ),
          ),
          // レポジトリ名
          title: Padding(
            padding: const EdgeInsets.all(4),
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
          trailing: Consumer(
            builder: (_, WidgetRef ref, __) {
              final sortMethodLogic = ref.read(sortMethodProvider);
              final icon = sortMethodLogic.getIcon();
              final iconName = sortMethodLogic.getIconName();
              final value = sortMethodLogic.getValue()(data);

              return Semantics(
                container: true,
                // 'stars 1234'というように読み上げられる
                label: '$iconName $value',
                child: Consumer(
                  builder: (context, ref, child) => ExcludeSemantics(
                    child: Column(
                      children: [
                        Icon(icon),
                        Text(value),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
