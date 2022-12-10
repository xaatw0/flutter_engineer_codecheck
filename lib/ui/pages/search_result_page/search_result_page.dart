import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../widgets/organisms/search_result_list_view.dart';

/// 検索結果を表示するためのページのView
class SearchResultPage extends ConsumerStatefulWidget {
  SearchResultPage({
    super.key,
    required this.keyword,
    required this.sortMethod,
  });

  /// 検索キーワード
  final String keyword;

  /// ソート方法
  final SortMethod sortMethod;

  /// パス内のキーワードの文字列
  static const kKeyword = 'keyword';

  /// 検索結果ページのパス
  static const path = '/search/:$kKeyword';

  @override
  ConsumerState<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends ConsumerState<SearchResultPage> {
  final SearchResultPageVm _vm = SearchResultPageVm();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
    _vm.onLoad(widget.keyword, widget.sortMethod);
  }

  @override
  Widget build(BuildContext context) {
    return DayNightTemplate(
      title: '[${widget.keyword}]の検索',
      children: [
        Expanded(
            child: _vm.getRepositoryData.when(
          error: (error, _) => Text(error.toString()),
          loading: () => LoadingRotating.square(),
          data: (data) => NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification notification) {
              bool isReachScrollEnd = notification.metrics.extentAfter == 0;
              if (isReachScrollEnd) {
                _vm.onLoadMore();
              }
              return isReachScrollEnd;
            },
            child: SearchResultListView(
              data: data,
              onTapped: _vm.onRepositoryTapped,
            ),
          ),
        )),
      ],
    );
  }
}
