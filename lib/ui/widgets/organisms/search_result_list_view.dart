import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/shimmer_card.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/tap_widget_animation.dart';

import '../../../domain/entities/git_repository_data.dart';
import '../molecules/repository_data_card.dart';

/// レポジトリの検索結果を表示するためのListView
class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    super.key,
    required this.data,
    this.onTapped,
    this.isLoading = false,
  });

  final List<GitRepositoryData> data;
  final void Function(BuildContext context, GitRepositoryData data)? onTapped;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (isLoading && index == data.length) {
          return ShimmerCard();
        }

        final repository = data[index];
        return TapWidgetAnimation(
          onTap: onTapped == null ? null : () => onTapped!(context, repository),
          child: RepositoryDataCard(
            data: repository,
          ),
        );
      },
    );
  }
}
