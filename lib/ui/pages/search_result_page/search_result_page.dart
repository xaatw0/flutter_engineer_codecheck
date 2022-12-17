import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../widgets/atoms/not_found_result.dart';
import '../../widgets/organisms/search_result_list_view.dart';

/// 検索結果を表示するためのページのView
class SearchResultPage extends ConsumerStatefulWidget {
  const SearchResultPage({
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
    final funcAfterInit = _vm.onLoad(widget.keyword, widget.sortMethod);
    WidgetsBinding.instance.addPostFrameCallback((_) => funcAfterInit());
  }

  @override
  Widget build(BuildContext context) {
    return DayNightTemplate(
      title: '${AppLocalizations.of(context).searchResult} [${widget.keyword}]',
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: _vm.getRepositoryData.when(
                error: (error, stacktrace) {
                  _vm
                      .onErrorOccurred(context, error)
                      .then((callback) => callback());

                  return Container();
                },
                loading: LoadingRotating.square,
                data: (data) => NotificationListener<ScrollEndNotification>(
                  onNotification: (ScrollEndNotification notification) {
                    final isReachScrollEnd =
                        notification.metrics.extentAfter == 0;
                    if (isReachScrollEnd) {
                      _vm.onLoadMore();
                    }
                    return isReachScrollEnd;
                  },
                  child: data.isEmpty
                      ? const NotFoundResult()
                      : SearchResultListView(
                          data: data,
                          onTapped: _vm.onRepositoryTapped,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
