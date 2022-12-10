import 'package:flutter/material.dart';

/// 検索用のテキストフィールド
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onSubmitted,
    required this.onSelectSortMethod,
  }) : super(key: key);

  /// キーボードの検索ボタン押下時のファンクション
  final void Function(String value) onSubmitted;
  final void Function() onSelectSortMethod;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        // TextField左端の虫眼鏡のアイコン(飾り)
        prefixIcon: const Icon(Icons.search),

        // TextField右端のソート方法選択のアイコン
        suffixIcon: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: onSelectSortMethod,
        ),
        hintText: '検索キーワード',
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
    );
  }
}
