import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/theme_switcher.dart';

import '../../../domain/string_resources.dart';

/// ライトテーマとダークテーマの切り替えボタンのあるテンプレート。
class DayNightTemplate extends StatelessWidget {
  const DayNightTemplate({
    Key? key,
    this.title,
    required this.child,
    this.isAppBarShown = true,
  }) : super(key: key);

  final Widget child;
  final String? title;

  /// アップバーを表示するか(true:表示 false:非表示)
  /// 画面を横向きにしたときのスペース確保のために非表示にできる
  final bool isAppBarShown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBarShown
          ? AppBar(
              title: Text(title ?? StringResources.kEmpty),
              actions: const [ThemeSwitcher()],
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
