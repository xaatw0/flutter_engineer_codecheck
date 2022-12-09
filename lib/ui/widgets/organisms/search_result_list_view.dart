import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/button_click_animation.dart';

import '../../../domain/entities/git_repository_data.dart';
import '../molecules/repository_data_card.dart';

/// レポジトリの検索結果を表示するためのListView
class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    Key? key,
    required this.data,
    this.onTapped,
  }) : super(key: key);

  final List<GitRepositoryData> data;
  final void Function(BuildContext context, GitRepositoryData data)? onTapped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final repository = data[index];
        return ButtonClickAnimation(
          onTap: onTapped == null ? null : () => onTapped!(context, repository),
          child: RepositoryDataCard(
            data: repository,
          ),
        );
      },
    );
  }
}
