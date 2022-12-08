import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/organisms/theme_switcher.dart';

/// ライトテーマとダークテーマの切り替えボタンのあるテンプレート。
class DayNightTemplate extends StatelessWidget {
  const DayNightTemplate({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
        actions: [ThemeSwitcher()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
