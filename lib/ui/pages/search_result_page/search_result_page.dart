import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../widgets/atoms/not_found_result.dart';
import '../../widgets/organisms/search_result_list_view.dart';
import '../../widgets/atoms/github_icon.dart';

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

    // 状態管理の変更は、initState完了後に実施する
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
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _vm.onErrorOccurred(error, context));

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

class ModalOverlay extends ModalRoute<void> {
  // ダイアログ内のWidget
  final Widget child;

  ModalOverlay(this.child) : super();

  /// ダイアログの表示・非表示の切り替わり時のアニメーションの時間
  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => false;

  /// ダイアログと前のページとの間の色
  @override
  Color get barrierColor => Colors.black.withOpacity(0.7);
  @override
  String get barrierLabel => 'test';
  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        return Future(() => true);
      },
    );
  }
}

class DisplayErrorDialog {
  const DisplayErrorDialog(this.context) : super();
  final BuildContext context;

  void showCustomDialog() {
    Navigator.push(
      context,
      ModalOverlay(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(32),
                  color: Colors.white54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // タイトル
                      Text(
                        "カスタムダイアログ",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // メッセージ
                      Text(
                        "こんな感じでダイアログが出せるよsadfsdfsdjflsdfksldjlzs;kjfl;sjf;lsejf;ljsefljselfse;lfjsle;fjeslfjl",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          "OK",
                        ),
                        onPressed: () {
                          hideCustomDialog();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  /*
   * 非表示
   */
  void hideCustomDialog() {
    Navigator.of(context).pop();
  }
}
