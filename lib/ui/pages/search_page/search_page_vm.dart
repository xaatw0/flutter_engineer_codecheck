import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索用のトップページのViewModel
class SearchPageVm {
  late WidgetRef _ref;

  /// 検索キーワードのProvider
  final _keyword = StateProvider<String>((ref) => '');

  /// テーマがダークモードになっているか
  bool get isDarkMode => _ref.watch(AppTheme.themeMode) == ThemeMode.dark;

  /// RiverpodのWidgetRefをVM内で共有する
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  /// 検索キーワードを変更したときに、内容を記録する
  void onKeywordChanged(String value) {
    _ref.read(_keyword.notifier).state = value;
  }

  void onSearch() {}
}
