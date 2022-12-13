import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/theme_switcher.dart';

import '../../../domain/string_resources.dart';

/// ライトテーマとダークテーマの切り替えボタンのあるテンプレート。
class DayNightTemplate extends StatefulWidget {
  const DayNightTemplate({
    super.key,
    this.title,
    required this.child,
    this.isAppBarShown = true,
    this.hasPadding = true,
  });

  /// 中身のWidget
  final Widget child;

  /// アップバーに表示するタイトル
  final String? title;

  /// アップバーを表示するか(true:表示 false:非表示)
  /// 画面を横向きにしたときのスペース確保のために非表示にできる
  final bool isAppBarShown;

  /// 標準のパディングをつけるか
  final bool hasPadding;

  @override
  State<DayNightTemplate> createState() => _DayNightTemplateState();
}

class _DayNightTemplateState extends State<DayNightTemplate> {
  static const normalPaddingSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBarShown && widget.hasPadding
          ? AppBar(
              title: Text(widget.title ?? StringResources.kEmpty),
              actions: const [ThemeSwitcher()],
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            normalPaddingSize,
            widget.hasPadding ? normalPaddingSize : 4,
            normalPaddingSize,
            0,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
