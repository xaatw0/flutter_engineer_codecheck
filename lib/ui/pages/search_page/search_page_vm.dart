import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 検索用のトップページのViewModel
class SearchPageVm {
  late WidgetRef _ref;

  /// テーマがダークモードになっているか
  bool get isDarkMode => _ref.watch(app_theme.themeMode) == ThemeMode.dark;

  /// RiverpodのWidgetRefをVM内で共有する
  // ignore: use_setters_to_change_properties
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  /// 画面が縦向きか判断する(true:縦向き false:横向き)
  bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  /// キーボードが表示されているか取得する(true:表示 false:非表示)
  bool isKeyboardShown(BuildContext context) =>
      0.0 < MediaQuery.of(context).viewInsets.bottom;

  /// キーワードが入力されているか取得する(true:入力あり false:入力なし)
  bool get isKeywordAvailable => _keyword.isNotEmpty;

  /// 選択されたソート方法
  SortMethod _selectedSortMethod = SortMethod.bestMatch;

  /// 入力された検索キーワード
  String _keyword = '';

  /// キーワードの入力時にキーワードを記録する
  // ignore: use_setters_to_change_properties
  void onChangeKeyword(String keyword) {
    _keyword = keyword;
  }

  /// 検索を実施する
  void onSearch(BuildContext context) {
    //キーワードが未入力の時は検索しない
    if (_keyword.isEmpty) {
      return;
    }
    final url = SearchResultPage.path
        .replaceFirst(':${SearchResultPage.kKeyword}', _keyword);
    GoRouter.of(context).push(url, extra: _selectedSortMethod);
  }

  /// ソート方法を選択するときに実施する
  Future<void> onSelectSortMethod(BuildContext context) async {
    final selectedSortMethod = await showConfirmationDialog<SortMethod>(
      context: context,
      title: AppLocalizations.of(context).sortOptions,
      initialSelectedActionKey: _selectedSortMethod,
      actions:
          // ソート方法の一覧から回答候補一覧を作る
          SortMethod.values
              .map(
                (method) => AlertDialogAction<SortMethod>(
                  key: method,
                  label: method.title,
                ),
              )
              .toList(),
    );

    if (selectedSortMethod != null) {
      _selectedSortMethod = selectedSortMethod;
    }
  }
}
