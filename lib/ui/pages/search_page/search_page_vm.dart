import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 検索用のトップページのViewModel
class SearchPageVm {
  late WidgetRef _ref;

  /// テーマがダークモードになっているか
  bool get isDarkMode => _ref.watch(AppTheme.themeMode) == ThemeMode.dark;

  /// RiverpodのWidgetRefをVM内で共有する
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  /// 選択されたソート方法
  SortMethod _selectedSortMethod = SortMethod.bestMatch;

  /// 検索を実施する
  void onSearch(String keyword, BuildContext context) {
    final url = SearchResultPage.path
        .replaceFirst(':${SearchResultPage.kKeyword}', keyword);
    GoRouter.of(context).push(url, extra: _selectedSortMethod);
  }

  /// ソート方法を選択するときに実施する
  Future<void> onSelectSortMethod(BuildContext context) async {
    final selectedSortMethod = await showConfirmationDialog<SortMethod>(
      context: context,
      title: 'ソート方法',
      message: 'ソートする方法を選択してください',
      initialSelectedActionKey: _selectedSortMethod,
      actions:
          // ソート方法から回答候補を作る
          SortMethod.values
              .map((method) => AlertDialogAction<SortMethod>(
                  key: method, label: _getSortMethodTitle(method)))
              .toList(),
    );

    if (selectedSortMethod != null) {
      _selectedSortMethod = selectedSortMethod;
    }
    print(selectedSortMethod);
  }

  /// ソート方法の表示を取得する
  /// TODO 国際化対応できるようにしたい
  String _getSortMethodTitle(SortMethod sortMethod) {
    return sortMethod.toString();
  }
}
