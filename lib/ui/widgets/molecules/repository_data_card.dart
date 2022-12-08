import 'package:flutter/material.dart';

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
        leading: OwnerImage(url: data.ownerIconUrl()),
        // レポジトリ名
        title: Text(
          data.repositoryName(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        // レポジトリの概要
        subtitle: Text(
          data.repositoryDescription() ?? '',
          style: const TextStyle(fontSize: 10, color: Color(0xff818181)),
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
