import 'package:flutter/material.dart';

import '../../../domain/entities/git_repository_data.dart';
import '../molecules/repository_data_card.dart';

/// レポジトリの検索結果を表示するためのListView
class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<GitRepositoryData> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final repository = data[index];
        return RepositoryDataCard(
          data: repository,
        );
      },
    );
  }
}
