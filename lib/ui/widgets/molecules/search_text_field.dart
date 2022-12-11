import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 検索用のテキストフィールド
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onChangeKeyword,
    required this.onSubmitted,
    required this.onSelectSortMethod,
  }) : super(key: key);

  /// キーワードが更新されたときのファンクション
  final void Function(String value) onChangeKeyword;

  /// キーボードの検索ボタン押下時のファンクション
  final void Function(String value) onSubmitted;

  /// ソート方法のアイコンが押されたときのイベント
  final void Function() onSelectSortMethod;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        // TextField左端の虫眼鏡のアイコン(飾り)
        prefixIcon: const Icon(Icons.search),

        // TextField右端のソート方法選択のアイコン
        suffixIcon: IconButton(
          icon: Icon(
            Icons.sort,
            size: 32.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: onSelectSortMethod,
        ),

        // 空白時(初期状態)でTextFiledに入力されている文字
        hintText: AppLocalizations.of(context).searchInGithub,
        hintStyle: Theme.of(context).textTheme.bodyMedium,

        // 角丸
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: onChangeKeyword,
      onSubmitted: onSubmitted,
    );
  }
}
