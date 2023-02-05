import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/shimmer_card.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/tap_widget_animation.dart';

import '../../../usecase/search_repositoies_use_case.dart';
import '../molecules/repository_data_card.dart';

/// レポジトリの検索結果を表示するためのListView
class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    super.key,
    required this.data,
    this.onTapped,
    this.isLoading = false,
  });

  final List<SearchRepositoryDto> data;
  final void Function(BuildContext context, SearchRepositoryDto data)? onTapped;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        // ロード中はシマｰカードを一番下に表示する
        if (isLoading && index == data.length) {
          return const ShimmerCard();
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
